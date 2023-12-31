import { Component } from '@angular/core';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { MenuItem } from 'primeng/api';
import { CarouselData } from 'src/app/models/carousel-data.model';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { User } from 'src/app/models/user.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-view-staff',
  templateUrl: './view-staff.component.html',
  styleUrls: ['./view-staff.component.scss']
})
export class ViewStaffComponent {

  isLoggedIn = false;

  user?: User;//biến lưu thông tin user
  slidesStore?: CarouselData[];
  isLoaded: boolean = false;
  loading: boolean = true
  currentImageIndex = 0;
  isAutoPlay = true;
  autoPlayInterval: any;
  listQuiz: any;
  listQuizStatus1: any;
  listQuizStatus2: any;
  listQuizStatus4: any;
  color: number = 3;
  colorQuestion: number = 2
  listCategory: any;
  showResultApprove = false;
  listQuestion: QuestionData[] = [];
  items: MenuItem[] = [
    {
      items: [
        {
          label: 'Add quiz',
          icon: 'pi pi-clone',
          routerLink: '/create-quiz-staff'
        },
        {
          label: 'Add question',
          icon: 'pi pi-stop',
          routerLink: '/create-question'
        }
      ]
    }
  ];

  customOptions: OwlOptions = {
    loop: true,
    mouseDrag: true,
    touchDrag: true,
    pullDrag: false,
    center: false,
    margin: 20,
    dots: false,
    autoplay: true,
    navSpeed: 700,
    navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
    responsive: {
      0: {
        items: 1,
      },
      400: {
        items: 2
      },
      740: {
        items: 3
      },
      940: {
        items: 4
      }
    },
    nav: true
  }



  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private fireBase: FirebaseImageService) {
  }

  async ngOnInit() {

    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.user = user;
        this.quizDataService.getListQuiForStaff().subscribe(res => {
          this.updateImageQuizSet2(res.result.quizzesStatus2);
          this.updateImageQuizSet1(res.result.quizzesStatus1);
          this.updateImageQuizSet4(res.result.quizzesStatus4);
          this.setSlidesStoreFromQuizList(res.result.quizzesStatus0);
          if (res) {
            this.quizDataService.getCategoryByStatus(2, this.user?.userId).subscribe(res => {
              this.listCategory = res
            })

          }
        })
      }
    });
  }


  async updateImageQuizSet4(quizs: Quiz[]) {
    if (quizs) {
      const promises = quizs.map(async (slide) => {
        if (slide.image) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            slide.image = '';
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.listQuizStatus4 = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý set quiz:', error);
      }
    }
  }

  async updateImageQuizSet1(quizs: Quiz[]) {
    if (quizs) {
      const promises = quizs.map(async (slide) => {
        if (slide.image) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            slide.image = '';
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.listQuizStatus1 = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý set quiz:', error);
      }
    }
  }

  async updateImageQuizSet2(quizs: Quiz[]) {
    if (quizs) {
      const promises = quizs.map(async (slide) => {
        if (slide.image) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            slide.image = '';
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.listQuizStatus2 = resolvedTop3;
        this.listQuiz = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý set quiz:', error);
      }
    }
  }

  async updateSlidesStoreWithFirebaseUrls(quizs: CarouselData[]) {
    if (quizs) {
      const promises = quizs.map(async (slide) => {
        if (slide.src) {
          try {
            const url = await this.fireBase.getImageUrl(slide.src).toPromise();
            slide.src = url;
          } catch (error) {
            slide.src = '';
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.slidesStore = resolvedTop3;
        this.isLoaded = true;

      } catch (error) {
        console.error('Lỗi khi xử lý set quiz:', error);
      }
    }
  }

  private setSlidesStoreFromQuizList(quizList: any[]): void {
    // Chuyển đổi dữ liệu từ danh sách quiz thành định dạng cần thiết cho slidesStore
    const convertedSlides: CarouselData[] = quizList.map((quiz) => {
      return {
        src: quiz.image ? quiz.image : '',  // Thay 'imagePath' bằng trường chứa đường dẫn hình ảnh trong đối tượng quiz
        title: quiz.title,    // Thay 'title' bằng trường chứa tiêu đề trong đối tượng quiz
        desc: quiz.description,  // Thay 'description' bằng trường chứa mô tả trong đối tượng quiz
        href: quiz.quizId,  // Thay 'id' bằng trường chứa id trong đối tượng quiz
      };
    });

    // Gán giá trị cho slidesStore
    this.slidesStore = convertedSlides;
    this.updateSlidesStoreWithFirebaseUrls(convertedSlides);
  }

  // truyền mã status để biết loại danh sách
  showList(status: number) {
    this.quizDataService.getListQuiForStaff().subscribe(res => {
      if (status == 1) {
        this.color = 1
        this.listQuiz = this.listQuizStatus1;
      }
      if (status == 3) {
        this.color = 3
        this.listQuiz = this.listQuizStatus2;
      }
      if (status == 2) {
        this.color = 2
        this.listQuiz = this.listQuizStatus4;
      }
    })
  }

  showListQuestion(status: number) {
    if (status == 1) {
      this.colorQuestion = 1
    }
    if (status == 3) {
      this.colorQuestion = 3
    }
    if (status == 2) {
      this.colorQuestion = 2
    }
    if (status == 3) {
      status = 4
    }
    this.quizDataService.getCategoryByStatus(status, this.user?.userId).subscribe(res => {
      this.listCategory = res;

    })
  }
  openDialog(categoyId: number) {
    // Set the boolean variable to true to show the dialog
    this.showResultApprove = true;
    this.getQuestionsByCategory(categoyId, this.colorQuestion);
  }

  getQuestionsByCategory(categoyId: number, status: number) {
    this.quizDataService.getQuestionsByCategory(categoyId, status, this.user?.userId).subscribe(res => {
      this.listQuestion = res.result
      this.loading = false
    })
  }

}
