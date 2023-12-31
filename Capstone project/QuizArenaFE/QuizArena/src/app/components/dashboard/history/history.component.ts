import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DashboardService } from 'src/app/services/dashboard.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-history',
  templateUrl: './history.component.html',
  styleUrls: ['./history.component.scss']
})
export class HistoryComponent {
  isLoading: boolean = true; // Ban đầu, hiển thị khối div lúc đang load
  listHistory: any
  searchTerm: string = ''
  loading: boolean = true;
  constructor(private dashboardService: DashboardService,  private userDataService: UserDataService, private router: Router) { }

  // Simulate loading data, ví dụ: sau 3 giây, tắt khối div
  ngOnInit() {
    setTimeout(() => {
      this.isLoading = false; // Tắt khối div sau khi tải dữ liệu xong
    }, 500); // Đây chỉ là ví dụ, bạn cần thay thời gian tương ứng với việc tải dữ liệu thực tế
     this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
      this.getHistoryUser()
      }
    });
  }

  getHistoryUser(){
    this.dashboardService.getUserHistory(this.searchTerm).subscribe(res =>{
      this.listHistory = res
      this.loading = false;
    })
  }

  onSearch() {
    this.dashboardService.getUserHistory(this.searchTerm).subscribe(
      (res: any) => {
        this.listHistory = res
      },
      (error: any) => {
        console.error('Error:', error);
        this.isLoading = false;
      }
    );
  }
}
