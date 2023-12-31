import { Component, OnInit } from '@angular/core';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { CarouselData } from 'src/app/models/carousel-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-contentlogin-home',
  templateUrl: './contentlogin-home.component.html',
  styleUrls: ['./contentlogin-home.component.scss']
})
export class ContentloginHomeComponent implements OnInit {
  isLoaded: boolean = false;
  numberLoad: number = 0;
  quizPopular?: Quiz;
  quizRecent?: Quiz;
  isRecent: boolean = true; // biến hiển thị quiz recent hay quiz popular
  slidesStore?: CarouselData[];
  slidesStorePopular?: CarouselData[];
  isDivQuiz: boolean = true; // biến hiển thị thẻ div quiz hay là casuol
  isDivQuizPopular: boolean = false; // biến hiển thị thẻ div quiz hay là casuol
  challenges: { examId?: string, examName?: string, description?: string, image?: string, status?: number, date?: Date, examType?: number }[] = []; // biến chứa dữ liệu list chall


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

  constructor(private fireBase: FirebaseImageService, private quizService: QuizDataService, private userDataService: UserDataService) { }
  async ngOnInit(): Promise<void> {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.getQuiz();
        return;
      }
    });
  }


  async getQuiz(): Promise<void> {

    this.quizService.getQuizPopularRecent().subscribe(
      (response: any) => {
        if (response.status) {
          if (response.result.quizRecentOfUser) {
            this.setSlidesStoreFromQuizList(response.result.quizRecentOfUser);
            this.setSlidesStoreFromQuizListPopular(response.result.dataPopular);
          } else {
            this.isRecent = false;
            this.setSlidesStoreFromQuizListPopular(response.result.dataPopular);
          }
          this.setupListChallenge(response.result.examRecent);
        } else {
          console.log(response.message);
        }
      },
      (error) => {
        console.error('Get quiz fail:', error);
      }
    );
  }


  /*
  * Hàm setup các thông tin cho danh sách challenge
  */
  private async setupListChallenge(chall: any[]) {
    if (chall) {
      const promises = chall.map(async (slide) => {
        if (slide.image && slide.image.length>0) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        } else {
          slide.image = '';
        }
        return slide;
      });

      try {
        const list = await Promise.all(promises);
        this.challenges = list;
      } catch (error) {
        console.error('Lỗi khi xử lý setup list challenge:', error);
      }
    }
  }

  private setSlidesStoreFromQuizList(quizList: any[]): void {
    // Chuyển đổi dữ liệu từ danh sách quiz thành định dạng cần thiết cho slidesStore
    const convertedSlides: CarouselData[] = quizList.map((quiz) => {
      return {
        src: quiz.image,  // Thay 'imagePath' bằng trường chứa đường dẫn hình ảnh trong đối tượng quiz
        title: quiz.title,    // Thay 'title' bằng trường chứa tiêu đề trong đối tượng quiz
        desc: quiz.description,  // Thay 'description' bằng trường chứa mô tả trong đối tượng quiz
        href: `/quiz-detail/${quiz.quizId}`,  // Thay 'id' bằng trường chứa id trong đối tượng quiz
      };
    });

    // Gán giá trị cho slidesStore
    this.slidesStore = convertedSlides;
    if (this.slidesStore.length > 2)
      this.isDivQuiz = false;
    if (this.slidesStore)
      this.updateSlidesStoreWithFirebaseUrls()
  }

  updateSlidesStoreWithFirebaseUrls() {

    if (this.slidesStore) {
      this.slidesStore.forEach((slide, index) => {
        if (this.slidesStore && this.slidesStore[index].src) {
          this.fireBase.getImageUrl(slide.src).subscribe(
            (url) => {
              if (this.slidesStore && this.slidesStore[index].src) {
                this.slidesStore[index].src = url;
              }
            },
            (error) => {
              console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
            }
          );
        } else {

        }
      });
    }
  }

  private setSlidesStoreFromQuizListPopular(quizList: any[]): void {
    // Chuyển đổi dữ liệu từ danh sách quiz thành định dạng cần thiết cho slidesStore
    const convertedSlides: CarouselData[] = quizList.map((quiz) => {
      return {
        src: quiz.image,  // Thay 'imagePath' bằng trường chứa đường dẫn hình ảnh trong đối tượng quiz
        title: quiz.title,    // Thay 'title' bằng trường chứa tiêu đề trong đối tượng quiz
        desc: quiz.description,  // Thay 'description' bằng trường chứa mô tả trong đối tượng quiz
        href: `/quiz-detail/${quiz.quizId}`,  // Thay 'id' bằng trường chứa id trong đối tượng quiz
      };
    });

    // Gán giá trị cho slidesStore
    this.setupListPopular(convertedSlides);
  }

   /*
  * Hàm setup các thông tin cho danh sách challenge
  */
   private async setupListPopular(quiz: any[]) {
    if (quiz) {
      const promises = quiz.map(async (slide) => {
        if (slide.src && slide.src.length>0) {
          try {
            const url = await this.fireBase.getImageUrl(slide.src).toPromise();
            slide.src = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        } else {
          slide.src = '';
        }
        return slide;
      });

      try {
        const list = await Promise.all(promises);
        if(list.length<2){
          this.isDivQuizPopular = true;
        }
        this.slidesStorePopular = list;
        this.isLoaded = true;

      } catch (error) {
        console.error('Lỗi khi xử lý setup list popular:', error);
      }
    }
  }

}
