import { Component, ElementRef, OnInit, Renderer2, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { User } from 'src/app/models/user.model';
import { AccountService } from 'src/app/services/account.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faPen } from '@fortawesome/free-solid-svg-icons';
import { UserUpdate } from 'src/app/models/update-user.model';
import { faCircle, faMagnifyingGlass } from '@fortawesome/free-solid-svg-icons';
import { DashboardService } from 'src/app/services/dashboard.service';
import { ChallengeService } from 'src/app/services/challenge.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
  @ViewChild('fileInput') fileInput?: ElementRef;
  modalMess = false;
  editMode = false;
  rankingPercent = 0;
  user?: User;
  selectedImage: File | undefined;
  updateForm!: FormGroup;
  errorMess?: string;
  showFriend: boolean = false
  listFriend: any
  searchTerm: string = ''
  totalFriend: number = 0
  userId: any
  achievements: { date?: Date, examName?: string, image?: string, score?: number, topUser?: number } = {}; // biến lưu trữ dữ liệu achievements
  isloading: boolean = true;
  //icon
  faPen = faPen;
  faCircle = faCircle
  faMagnifyingGlass = faMagnifyingGlass


  ngOnInit(): void {
    this.authService.userCurr.subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.userId = userData.userId
        this.caculateExp();
        this.getSearch()
      }
    });
  }

  constructor(private authService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService, private accService: AccountService, private dashboardService: DashboardService
    , private formBuilder: FormBuilder, private challengeService: ChallengeService) {
    this.updateForm = this.formBuilder.group({
      fullname: [''],
      email: [''],
      description: ['']
    });
  }

  private async getAchievement() {
    await this.challengeService.getInforChallengePage().subscribe(
      (response) => {
        if (response.status) {
          if (!response.result.examInfoUser) {
            this.isloading = false;
          } else {
            this.setAchievements(response.result.examInfoUser);
          }
        } else {
          this.isloading = false;
        }
      },
      (error) => {
        this.isloading = false;
        console.error('Lỗi khi lấy thông tin trang:', error);
      }
    );
  }

  private async setAchievements(achie: any): Promise<void> {
    if (achie && achie.image) {
      await this.fireBase.getImageUrl(achie.image).subscribe(
        (url) => {
          achie.image = url;
          this.achievements = achie;
          this.isloading = false;
        },
        (error) => {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      );
    } else {
      this.achievements = achie;
      this.isloading = false;
    }
  }

  getSearch() {
    this.dashboardService.getFriends(this.userId, this.searchTerm).subscribe(res => {
      this.setupListFriends(res);
      this.totalFriend = res.length;
      this.getAchievement();
    })
  }

  /*
 * Hàm setup các thông tin cho danh sách bạn bè
 */
  private async setupListFriends(friends: User[]) {
    if (friends) {
      const promises = friends.map(async (slide) => {
        if (slide.images) {
          try {
            const url = await this.fireBase.getImageUrl(slide.images).toPromise();
            slide.images = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        } else {
          slide.images = '';
        }
        return slide;
      });

      try {
        const list = await Promise.all(promises);
        this.listFriend = list;
      } catch (error) {
        console.error('Lỗi khi xử lý setup list friends:', error);
      }
    }
  }

  onSearch() {
    this.getSearch()
  }

  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
  }

  onFileSelected(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files[0] && this.user) {
      if (input.files[0].type === 'image/jpeg' || input.files[0].type === 'image/jpg') {
        const filePath = this.fireBase.uploadImage(input.files[0], this.user.username);
        const userUpdate: UserUpdate = {
          images: filePath
        }
        this.accService.update(userUpdate).subscribe(
          (response: any) => {
            if (response.status) {
              window.location.reload();
            } else {
              console.error('Update failed');
            }
          },
          (error) => {
            console.error('Call api failed:', error);
          }
        );
      } else {
        // Hiển thị modal thông báo
        this.modalMess = true;
      }
    }
  }

  closeModal() {
    this.modalMess = false;
  }

  toggleEditMode() {
    this.editMode = !this.editMode;
    this.errorMess = '';
    this.updateForm = this.formBuilder.group({
      fullname: [this.user?.fullname],
      email: [this.user?.email],
      description: [this.user?.description]
    });
  }

  saveChanges() {
    if (this.updateForm.invalid) {
      return;
    }

    const fullname = this.updateForm.get('fullname')?.value;
    const email = this.updateForm.get('email')?.value;
    const description = this.updateForm.get('description')?.value;
    const regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (fullname && email && description) {
      if (!regexEmail.test(email)) {
        this.errorMess = 'Invalid email format';
        return;
      } else {
        const userUpdate: UserUpdate = {
          fullname: fullname,
          email: email,
          description: description,
        };

        this.accService.update(userUpdate).subscribe(
          (response: any) => {
            if (response.status) {
              window.location.reload();
            } else {
              this.errorMess = response.message;
            }
          },
          (error) => {
            console.error('Update failed:', error);
            this.errorMess = error.error.message;
          }
        );
      }
    }
  }

  onImageSelected(event: any) {
    const selectedFile = event.target.files[0];
    if (selectedFile) {
      this.selectedImage = selectedFile;
    }
  }

  private caculateExp() {
    if (this.user) {
      if (this.user.exp < 1000) {
        this.rankingPercent = (this.user.exp / 1000) * 100;
      }
      if (this.user.exp < 10000 && this.user.exp >= 1000) {
        this.rankingPercent = (this.user.exp / 10000) * 100;
      }
      if (this.user.exp >= 10000) {
        this.rankingPercent = 100;
      }
    }
  }

  showListFriend() {

    if (this.showFriend) {
      this.showFriend = false
    } else {
      this.showFriend = true
    }
  }

}
