import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { faDotCircle } from '@fortawesome/free-solid-svg-icons';
import { Quiz } from 'src/app/models/quiz-data.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';


@Component({
  selector: 'app-user-view-list-quiz',
  templateUrl: './user-view-list-quiz.component.html',
  styleUrls: ['./user-view-list-quiz.component.scss']
})
export class UserViewListQuizComponent {

  faDotCircle = faDotCircle

  listCategoryQuiz: any;
  listQuiz?: any[];
  searchText: string = "";
  listQuizRestore?: any[];

  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private router: Router
    , private fireBase: FirebaseImageService) { }

  async ngOnInit() {
    const token = localStorage.getItem('authToken');
    if (token) {
      await this.userDataService.userCurr.subscribe(user => {
        if (user.userId) {
          this.getCategoryQuiz()
        }
      });
    } else {
      this.getCategoryQuiz()
    }

  }

  getCategoryQuiz() {
    this.quizDataService.getCategory().subscribe(
      res => {
        this.listCategoryQuiz = res.result
        this.getListQuizActive();
      }
    )
  }

  getListQuizActive() {
    this.quizDataService.getListQuizActive().subscribe(
      res => {
        const filteredQuizResults: Quiz[] = res.result.filter((quiz: Quiz) => quiz.title?.toLocaleLowerCase().includes(this.searchText.toLocaleLowerCase()));
        this.updateSlidesStoreWithFirebaseUrls(filteredQuizResults)
      }
    )
  }

  async updateSlidesStoreWithFirebaseUrls(quizs: Quiz[]) {
    if (quizs) {
      const promises = quizs.map(async (slide) => {
        if (slide.image) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.listQuiz = resolvedTop3;
        this.listQuizRestore = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý set quiz:', error);
      }
    }
  }

  getListQuizByCategoryId(event: Event, categoryId: number) {
    event.preventDefault();
    if (categoryId !== 0 && this.listQuizRestore) {
      const filteredQuizzes = this.listQuizRestore.filter(quiz => quiz.categoryId === categoryId);
      this.listQuiz = filteredQuizzes;
    } else {
      this.getListQuizActive()
    }
  }
}
