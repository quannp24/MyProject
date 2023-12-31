import { Component, OnInit } from '@angular/core';
import { LazyLoadEvent } from 'primeng/api';
import { Quiz } from 'src/app/models/quiz-data.model';
import { User } from 'src/app/models/user.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-your-library',
  templateUrl: './your-library.component.html',
  styleUrls: ['./your-library.component.scss']
})
export class YourLibraryComponent implements OnInit {

  loading: boolean = true;
  quizlist: Quiz[] = [];
  user?: User;

  constructor(private authService: UserDataService, private quizService: QuizDataService) { }

  async ngOnInit(): Promise<void> {
    await this.authService.userCurr.subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.setupQuizPrivate();
      }
    });
  }

  private async setupQuizPrivate() {
    if (this.user?.userId)
      await this.quizService.getListQuizPrivate(this.user?.userId).subscribe(
        (res) => {
          if (res.status) {
            this.quizlist = res.result;
            this.loading = false;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu quiz private:', error);
        }
      );
  }


  groupDataByMonth(data: Quiz[]): any {
    return data.map(item => {
      if (item.createDate) {
        const monthYear = this.getMonthYearFromDate(item.createDate);
        return { ...item, monthYear };
      }
      return item;
    });
  }

  getMonthYearFromDate(date: Date): string {
    return new Date(date).toLocaleString('en-us', { month: 'long', year: 'numeric' });
  }




}
