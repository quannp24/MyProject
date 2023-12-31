import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { CarouselData } from 'src/app/models/carousel-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faChartLine, faUserGroup } from '@fortawesome/free-solid-svg-icons';
import { AccountService } from 'src/app/services/account.service';
import { User } from 'src/app/models/user.model';
import { SignalrService } from 'src/app/services/signalr.service';


@Component({
  selector: 'app-quiz-practic-detail',
  templateUrl: './quiz-practic-detail.component.html',
  styleUrls: ['./quiz-practic-detail.component.scss']
})
export class QuizPracticDetailComponent implements OnInit {
  quiz?: Quiz;
  quizId?: number;
  user?: User;
  totalQues?: number;
  creator?: User;
  isLoaded: boolean = false;
  numberLoad: number = 0;
  isDivQuiz: boolean = true; // biến hiển thị thẻ div quiz hay là casuol
  slidesStore?: CarouselData[];
  messError?: string;
  isImageLoaded: boolean = false; // biến hiển thị ảnh quiz
  showUpgrade: boolean = false; // biến hiển thị modal upgrade
  numDoDay?: number; // biến số lượng người làm quiz hôm nay
  numDoMonth?: number; // biến số lượng người làm quiz tháng này


  //icon
  faChartLine = faChartLine;
  faUserGroup = faUserGroup;


  constructor(private quizService: QuizDataService, private route: ActivatedRoute, private fireBase: FirebaseImageService,
    private userDataService: UserDataService, private accountService: AccountService, private router: Router, private signalRService: SignalrService) {

  }

  async ngOnInit(): Promise<void> {
    this.route.params.subscribe(params => {
      this.quizId = params['quizId']; // Lấy giá trị quizId từ đường dẫn
    });

    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.user = user;
        if (this.quizId) {
          this.onStartQuiz(this.quizId);
        }
      }
    });

  }

  onStartQuiz(quizId: number) {
    this.isImageLoaded = false;
    this.quizId = quizId;
    // Gọi service để lấy dữ liệu quiz
    this.quizService.getquiz(this.quizId).subscribe(
      (response) => {
        if (response.result.quizz.quizType == 3) {
          this.router.navigate(['/quiz-private-detail', this.quizId]);
        } else {
          if (response.result.quizz.image) {
            this.fireBase.getImageUrl(response.result.quizz.image).subscribe(
              (url) => {

                response.result.quizz.image = url;
                //lay image cua creator
                if (response.result.quizz.creatorId) {
                  this.accountService.getUserId(response.result.quizz.creatorId).subscribe(
                    (response) => {
                      if (!this.isLoaded) {
                        this.getQuiz();
                      } else {
                        this.getNumberDoToday()
                      }
                      //lay image cua creator
                      if (response.result.images) {
                        this.fireBase.getImageUrl(response.result.images).subscribe(
                          (url) => {
                            response.result.images = url;
                            this.creator = response.result;
                            this.isImageLoaded = true;
                          },
                          (error) => {
                            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
                          }
                        );
                      } else {
                        this.creator = response.result;
                        this.isImageLoaded = true;
                      }
                    },
                    (error) => {
                      console.error('Lỗi khi lấy dữ liệu creator:', error);
                    }
                  );
                }
              },
              (error) => {
                console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
              }
            );
          } else {

            //lay image cua creator
            if (response.result.quizz.creatorId) {
              this.accountService.getUserId(response.result.quizz.creatorId).subscribe(
                (response) => {
                  if (!this.isLoaded) {
                    this.getQuiz();
                  } else {
                    this.getNumberDoToday()
                  }
                  //lay image cua creator
                  if (response.result.images) {
                    this.fireBase.getImageUrl(response.result.images).subscribe(
                      (url) => {
                        response.result.images = url;
                        this.creator = response.result;
                        this.isImageLoaded = true;
                      },
                      (error) => {
                        console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
                      }
                    );
                  } else {
                    this.creator = response.result;
                    this.isImageLoaded = true;
                  }
                },
                (error) => {
                  console.error('Lỗi khi lấy dữ liệu creator:', error);
                }
              );
            }
          }
          this.quiz = response.result.quizz;
          this.totalQues = response.result.questions.length;
        }
      },
      (error) => {
        console.error('Lỗi khi lấy dữ liệu quiz:', error);
      }
    );
  }


  private async getNumberDoToday(): Promise<void> {
    if (this.quizId)
      this.quizService.getUserDoQuizToday(this.quizId).subscribe(
        (response) => {
          if (response.status) {
            this.numDoDay = response.result.numDay;
            this.numDoMonth = response.result.numMonth;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu người làm quiz:', error);
        }
      );
  }


  updateSlidesStoreWithFirebaseUrls() {

    if (this.slidesStore) {
      this.slidesStore.forEach((slide, index) => {
        if (this.slidesStore && this.slidesStore[index].src) {
          this.fireBase.getImageUrl(slide.src).subscribe(
            (url) => {
              if (this.slidesStore && this.slidesStore[index].src) {
                this.slidesStore[index].src = url;
                this.numberLoad++;
                if (this.numberLoad == this.slidesStore.length) {
                  this.isLoaded = true;
                }
              }
            },
            (error) => {
              console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
            }
          );
        } else {
          this.numberLoad++;
          if (this.slidesStore && this.numberLoad == this.slidesStore.length) {
            this.isLoaded = true;
          }
        }
      });
    }
  }

  async createRoomDoQuiz(quizId: number) {
    if (this.user) {
      if (this.user.role != 4) {
        await this.quizService.createRoomQuiz(quizId).subscribe(
          (response: any) => {
            if (response.status) {
              if (response.result)
                this.router.navigate(['/do-quiz-friends/' + quizId + '/' + response.result]);
            } else {
              this.messError = response.message;
            }
          },
          (error) => {
            console.error('Create room fail:', error);
          }
        );
      } else {
        this.showUpgrade = true;
      }
    }
  }

  async getQuiz(): Promise<void> {

    this.quizService.getQuizPopularRecent().subscribe(
      (response: any) => {
        if (response.status) {
          if (response.result.dataPopular) {
            this.setSlidesStoreFromQuizList(response.result.dataPopular);
            this.getNumberDoToday();
          }
        } else {
          console.log(response.message);
        }
      },
      (error) => {
        console.error('Get quiz fail:', error);
      }
    );
  }

  redirectDetail(quizId: string) {
    this.quizId = parseInt(quizId);
    if (this.quizId) {
      this.onStartQuiz(this.quizId);
    }
  }

  private setSlidesStoreFromQuizList(quizList: any[]): void {
    // Chuyển đổi dữ liệu từ danh sách quiz thành định dạng cần thiết cho slidesStore
    const convertedSlides: CarouselData[] = quizList.map((quiz) => {
      return {
        src: quiz.image,  // Thay 'imagePath' bằng trường chứa đường dẫn hình ảnh trong đối tượng quiz
        title: quiz.title,    // Thay 'title' bằng trường chứa tiêu đề trong đối tượng quiz
        desc: quiz.description,  // Thay 'description' bằng trường chứa mô tả trong đối tượng quiz
        href: quiz.quizId,  // Thay 'id' bằng trường chứa id trong đối tượng quiz
      };
    });

    // Gán giá trị cho slidesStore
    this.slidesStore = convertedSlides;
    if (this.slidesStore.length > 2)
      this.isDivQuiz = false;
    if (this.slidesStore)
      this.updateSlidesStoreWithFirebaseUrls()
  }


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
}
