import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DashboardService } from 'src/app/services/dashboard.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-earning-money',
  templateUrl: './earning-money.component.html',
  styleUrls: ['./earning-money.component.scss']
})
export class EarningMoneyComponent {
  isLoading: boolean = true; // Ban đầu, hiển thị khối div lúc đang load
  listEarning: any
  searchTerm: string = ''
  loading: boolean = true;
  saleMonth!: number
  saleLifeTime!: number
  constructor(private dashboardService: DashboardService,  private userDataService: UserDataService, private router: Router) { }

  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.dashboardService.getDashboardStatistics().subscribe(
          (stats: any) => {
            this.saleMonth = stats.totalSalesThisMonth
            this.saleLifeTime = stats.totalSales
            if(stats){
              this.getPaymentsWithUsername()
            }
            this.isLoading = false;
          },
          (error: any) => {
            console.error('Error:', error);
            this.isLoading = false;
          }
        );
      }
    })
  }

  getPaymentsWithUsername(){
    this.dashboardService.getPaymentsWithUsername(this.searchTerm).subscribe(res =>{
      this.listEarning = res
      this.loading = false;
    })
  }
}
