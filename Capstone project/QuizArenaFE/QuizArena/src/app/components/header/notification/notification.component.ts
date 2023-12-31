import { Component, Input, OnInit } from '@angular/core';
import { FeatureCommonService } from 'src/app/services/feature-common.service';

@Component({
  selector: 'app-notification',
  templateUrl: './notification.component.html',
  styleUrls: ['./notification.component.scss']
})
export class NotificationComponent {
  isDropdownOpen = false;
  notificationCount: number = 5;
  notifyList: { contentNotification?: string, value?: string, dateNotification?: Date }[] = [];

  constructor(private commonService: FeatureCommonService) { }



  toggleDropdown() {
    if (!this.isDropdownOpen) {
      this.commonService.getNotify().subscribe(
        (response) => {
          if (response.status) {
            this.notifyList = response.result;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy notify:', error);
        }
      );
    }
    this.isDropdownOpen = !this.isDropdownOpen;

  }

  closeDropdown() {
    this.isDropdownOpen = false;
  }
}


