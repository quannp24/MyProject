import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { faArrowRightFromBracket, faIdBadge, faHouse,faUsers, faChalkboardUser, faMoneyCheckDollar, faBookOpenReader, faCameraRetro, faClipboardQuestion } from '@fortawesome/free-solid-svg-icons';
import { User } from 'src/app/models/user.model';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-left-sidebar',
  templateUrl: './left-sidebar.component.html',
  styleUrls: ['./left-sidebar.component.scss']
})
export class LeftSidebarComponent {

  userData!: User;
  constructor( private userDataService: UserDataService, private router: Router,
    private jwtService: JwtService) {}
    isLoggedIn = false;
  faArrowRightFromBracket = faArrowRightFromBracket;
  faIdBadge = faIdBadge;
  faHouse = faHouse;
  faUsers = faUsers;
  faChalkboardUser = faChalkboardUser;
  faMoneyCheckDollar = faMoneyCheckDollar;
  faBookOpenReader = faBookOpenReader
  faCameraRetro = faCameraRetro
  faClipboardQuestion = faClipboardQuestion
  async ngOnInit(): Promise<void> {
    // Kiểm tra xem token có tồn tại trong localStorage không
    const token = localStorage.getItem('authToken');
    if (token) {
      // Nếu có token, đánh dấu là đã đăng nhập
      if (!this.jwtService.checkTokenExpired(token)) {
        this.isLoggedIn = true;
        await this.userDataService.userCurr.subscribe(user => {
          if (user.userId) {
            this.userData = user;
          } else {
            this.userDataService.setUserToken();
          }
        });
      } else {
        this.isLoggedIn = false;
      }
    } else {
      // Nếu không có token, đánh dấu là chưa đăng nhập
      this.isLoggedIn = false;
    }
  }

  logout() {
    const currentURL = this.router.url;
    localStorage.removeItem('authToken');
    if (currentURL === '/home') {// ktra nếu là login ở home thì load lại
      window.location.reload();
    } else {
      this.router.navigate(['/home']); // nếu login ở page login thì chuyển tới home
    }
  }

}
