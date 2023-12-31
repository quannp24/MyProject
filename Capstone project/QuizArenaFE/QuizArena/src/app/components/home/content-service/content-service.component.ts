import { Component } from '@angular/core';

@Component({
  selector: 'app-content-service',
  templateUrl: './content-service.component.html',
  styleUrls: ['./content-service.component.scss']
})
export class ContentServiceComponent {
  // Biến trạng thái cho việc hiển thị nội dung
  currentContent: number = 0;

  // ...

  // Hàm xử lý khi nhấp vào mục menu
  onMenuItemClick(index: number) {
    // Gán giá trị biến trạng thái
    this.currentContent = index;
    // ...
  }
}
