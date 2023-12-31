import { Component, OnInit } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { User } from 'src/app/models/user.model';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  isLoggedIn = false;
  userData!: User;
  images: string[] = [  // array banner slide
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  currentImageIndex = 0;
  isAutoPlay = true;
  autoPlayInterval: any;

  get currentImage(): string {
    return this.images[this.currentImageIndex];
  }

  constructor(private titleService: Title, private userDataService: UserDataService, private jwtService: JwtService) { }

  ngOnInit(): void {
    this.titleService.setTitle('QuizArena');
    this.startAutoPlay();

    // Kiểm tra xem token có tồn tại trong localStorage không
    const token = localStorage.getItem('authToken');
    if (token) {
      if (!this.jwtService.checkTokenExpired(token.toString())) {
        this.isLoggedIn = true;
        this.userDataService.userCurr.subscribe(user => {
          if (user) {
            this.userData = user;
            return;
          }
        });
      }else{
        this.isLoggedIn = false;
      }
    } else {
      // Nếu không có token, đánh dấu là chưa đăng nhập
      this.isLoggedIn = false;
    }
  }

  nextSlide(): void {
    this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
  }

  prevSlide(): void {
    this.currentImageIndex =
      this.currentImageIndex === 0
        ? this.images.length - 1
        : this.currentImageIndex - 1;
  }

  toggleAutoPlay(): void {
    this.isAutoPlay = !this.isAutoPlay;
    if (this.isAutoPlay) {
      this.startAutoPlay();
    } else {
      this.stopAutoPlay();
    }
  }

  startAutoPlay(): void {
    this.autoPlayInterval = setInterval(() => {
      if (this.isAutoPlay) {
        this.nextSlide();
      }
    }, 3000); // tgian slide
  }

  stopAutoPlay(): void {
    clearInterval(this.autoPlayInterval);
  }

  changeForm() {
    this.userDataService.setloginForm(true);
  }
}
