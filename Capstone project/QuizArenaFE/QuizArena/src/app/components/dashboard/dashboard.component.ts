import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Chart } from 'angular-highcharts';
import { DashboardService } from 'src/app/services/dashboard.service';
import { JwtService } from 'src/app/services/jwt.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent {
  isLoggedIn = false;

  constructor(private dashboardService: DashboardService, private userDataService: UserDataService, private quizDataService: QuizDataService) { }

  isLoading: boolean = true;
  totalMembers: any;
  totalQuizzes: any;
  totalMembersVip: any;
  totalSalesThisMonth: any;
  totalQuizlevel1: any;
  totalQuizlevel2: any;
  totalQuizlevel3: any;
  monthDays: string[] = [];
  userInMonth: any[] = [];
  revenueInMonth: any[] = [];
  linechart: any
  totalQuestion = 0
  async ngOnInit(): Promise<void> {

    const currentDate = new Date();
    const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const daysInMonth = (currentDate.getTime() - firstDayOfMonth.getTime()) / (1000 * 3600 * 24);
    for (let i = 0; i <= daysInMonth; i++) {
      const currentDay = new Date(firstDayOfMonth.getTime() + i * (1000 * 3600 * 24));
      const formattedDate = this.formatDate(currentDay);
      this.monthDays.push(formattedDate);
    }
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.dashboardService.getDashboardStatistics().subscribe(
          (data: any) => {
            this.totalMembers = data.totalUsers;
            this.totalQuizzes = data.totalQuizzes;
            this.totalMembersVip = data.totalUsersVip;
            this.totalSalesThisMonth = data.totalSalesThisMonth;
            this.totalQuizlevel1 = data.totalQuizlevel1;
            this.totalQuizlevel2 = data.totalQuizlevel2;
            this.totalQuizlevel3 = data.totalQuizlevel3;
            this.totalQuestion = data.numQuestion.numAll;
            this.isLoading = false;



            for (let i = 0; i < this.monthDays.length; i++) {
              this.userInMonth.push(data.dailyMembers[i])
              this.revenueInMonth.push(data.dailySales[i])
            }
            this.linechart = new Chart({
              chart: {
                type: 'line'
              },
              title: {
                text: 'Revenue and New User In Month'
              },
              credits: {
                enabled: false
              },
              xAxis: {
                categories: this.monthDays  // Thay đổi giá trị trục x tại đây
              },
              yAxis: {
                title: {
                  text: 'Value' // Thay đổi tiêu đề trục y tại đây
                }
              },
              series: [
                {
                  name: 'User',
                  data: this.userInMonth
                } as any,
                {
                  name: 'Revenue',
                  data: this.revenueInMonth,
                  color: "#544fc5"
                } as any,
              ],
            });

          },
          (error: any) => {
            console.error('Error:', error);
            this.isLoading = false;
          }
        );
      }
    });
  }

  private formatDate(date: Date): string {
    return `${date.getDate()}/${date.getMonth() + 1}`;
  }


}
