import { Component, ElementRef, Renderer2, HostListener, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user.model';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faIdBadge, faBarsProgress, faAngleDoubleUp, faArrowRightFromBracket, faMagnifyingGlass, faXmark, faFolderPlus, faBook, faUserTie } from '@fortawesome/free-solid-svg-icons';
import { SignalrService } from 'src/app/services/signalr.service';
import { fadeOutIn, slideInFromBottom } from 'src/assets/animations/animation-quiz';
import { FeatureCommonService } from 'src/app/services/feature-common.service';
import { SearchData } from 'src/app/models/search-data.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';


@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
  animations: [slideInFromBottom, fadeOutIn]
})
export class HeaderComponent implements OnInit {
  userData!: User;
  isLoggedIn = false;
  username?: string;
  isNotifyInvite: boolean = false;
  inforInvite?: any; // biến lưu trữ thông tin bạn bè mời làm quiz để thông báo
  searchTerm!: string; // biến search
  showResults: boolean = false;
  searchResultsUser: SearchData[] = [];
  searchResultsQuiz: SearchData[] = [];
  searchResultsExam: SearchData[] = [];
  showUpgrade: boolean = false; // biến hiển thị modal upgrade


  //icon
  faIdBadge = faIdBadge;
  faBarsProgress = faBarsProgress;
  faAngleDoubleUp = faAngleDoubleUp;
  faArrowRightFromBracket = faArrowRightFromBracket;
  faMagnifyingGlass = faMagnifyingGlass;
  faXmark = faXmark;
  faBook = faBook;
  faUserTie = faUserTie;
  faFolderPlus = faFolderPlus;

  async ngOnInit(): Promise<void> {
    // Kiểm tra xem token có tồn tại trong localStorage không
    const token = localStorage.getItem('authToken');
    if (token) {
      // Nếu có token, đánh dấu là đã đăng nhập
      if (!this.jwtService.checkTokenExpired(token)) {
        this.isLoggedIn = true;
        await this.userDataService.userCurr.subscribe(user => {
          if (user.userId) {
            this.userData = user;
            this.signalRService.isConnectedSubject.subscribe((isConnected) => {
              if (isConnected && this.signalRService.isConnected()) {
                this.signalRService.NotifyInviteDoQuiz((data: any) => {  //nghe sự kiện lời mời làm quiz
                  if (data.status) {
                    this.inforInvite = data.result;
                    this.isNotifyInvite = true;
                    setTimeout(() => {
                      this.isNotifyInvite = false;
                    }, 10000);
                  }
                });
              } else {
                this.signalRService.startConnection(user.userId); //mở kết nối signalR
              }
            });
            return;
          } else {
            this.userDataService.setUserToken();
          }
        });
      } else {
        this.isLoggedIn = false;
      }
    } else {
      // Nếu không có token, đánh dấu là chưa đăng nhập
      this.isLoggedIn = false;
    }

    this.getSearchInfor()
  }

  getSearchInfor(): void {
    this.commonService.searchInfo().subscribe(results => {
      if (results.status && this.searchTerm) {
        // const { userResults, examResults, quizResults } = results.result;

        // Lọc kết quả cho userResults
        if (results.result.userResult) {
          const filteredUserResults: SearchData[] = results.result.userResult.filter((user: SearchData) => user.name?.includes(this.searchTerm));
          this.getImageUserFirebase(filteredUserResults.slice(0, 5));
        }

        // Lọc kết quả cho examResults
        if (results.result.examResults) {
          const filteredExamResults: SearchData[] = results.result.examResults.filter((exam: SearchData) => exam.name?.includes(this.searchTerm));
          this.searchResultsExam = filteredExamResults.slice(0, 5);
        }

        if (results.result.quizResults) {
          const filteredQuizResults: SearchData[] = results.result.quizResults.filter((quiz: SearchData) => quiz.name?.includes(this.searchTerm));
          this.searchResultsQuiz = filteredQuizResults.slice(0, 5);
        }

      }
    });
  }

  showModalPay() {
    this.showUpgrade = true;
  }

  /*
  * Hàm xử lý lời mời làm quiz
  */
  async AcceptInvite(roomId: string, quizId: number): Promise<void> {
    if (this.userData.role != 4) {
      if (roomId.length > 0 && quizId > 0) {
        this.router.navigate(['/do-quiz-friends/' + quizId + '/' + roomId]);
      }
    } else {
      this.showUpgrade = true;
    }

  }

  private async getImageUserFirebase(users: SearchData[]) {
    let count = 0;
    if (users) {
      await users.forEach((slide, index) => {
        if (slide.image) {
          this.fireBase.getImageUrl(slide.image).subscribe(
            (url) => {
              if (users) {
                users[index].image = url;
                count++;

                if (count === users.length) {
                  this.searchResultsUser = users;
                }
              }
            },
            (error) => {
              console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
            }
          );
        } else {
          count++;
          if (count === users.length) {
            this.searchResultsUser = users;
          }
        }
      });
    }
  }

  closeResultSearch() {
    this.showResults = false;
  }


  onSearch() {
    this.showResults = true;
    if (this.searchTerm.length < 1) {
      this.searchResultsExam = [];
      this.searchResultsUser = [];
      this.searchResultsQuiz = [];
    } else {
      this.getSearchInfor();
    }
  }

  @HostListener('document:click', ['$event'])
  onClickOutside(event: Event) {
    if (!this.el.nativeElement.contains(event.target)) {
      this.showResults = false;
    }
  }



  constructor(private renderer: Renderer2, private el: ElementRef,
    private userDataService: UserDataService, private router: Router,
    private jwtService: JwtService, private signalRService: SignalrService
    , private commonService: FeatureCommonService, private fireBase: FirebaseImageService) {
  }

  @HostListener('window:scroll', ['$event'])
  onWindowScroll(event: Event): void {
    const scrollY = window.scrollY;
    const header = this.el.nativeElement.querySelector('header');
    const defaultHeight = 100;

    if (scrollY > 254 && header.clientHeight > 80) {
      this.renderer.setStyle(header, 'height', '80px');
      return;
    }
    if (scrollY > 254) return;

    let newHeight = defaultHeight - scrollY / 7;
    if (newHeight < 80) newHeight = 80;
    this.renderer.setStyle(header, 'height', `${newHeight}px`);
  }

  logout() {
    const currentURL = this.router.url;
    localStorage.removeItem('authToken');
    if (currentURL === '/home') {// ktra nếu là login ở home thì load lại
      window.location.reload();
    } else {
      this.router.navigate(['/home']); // nếu login ở page login thì chuyển tới home
    }
  }

  changeForm() {
    this.userDataService.setloginForm(true);
  }

}
