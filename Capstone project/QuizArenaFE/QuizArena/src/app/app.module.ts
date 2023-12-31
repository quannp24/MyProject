import { NgModule } from '@angular/core';
import { BrowserModule, Title  } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { HeaderComponent } from './components/header/header.component';
import { FooterComponent } from './components/footer/footer.component';
import { ContentServiceComponent } from './components/home/content-service/content-service.component';
import { ForgotpasswordComponent } from './components/forgotpassword/forgotpassword.component';
import { ProfileComponent } from './components/profile/profile.component';
import { ModalLoginComponent } from './components/home/modal-login/modal-login.component';
import { ContentloginHomeComponent } from './components/home/contentlogin-home/contentlogin-home.component';
import { CarouselModule, CarouselModule as OwlCarouselModule } from 'ngx-owl-carousel-o';
import { NotificationComponent } from './components/header/notification/notification.component';
import { LoginPageComponent } from './components/login/login-page/login-page.component';
import { ModalFormComponent } from './components/profile/modal-form/modal-form.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { ChartModule } from 'angular-highcharts';
import { DoQuizPracticeComponent } from './components/quiz-practive/do-quiz-practice/do-quiz-practice.component';
import { HeaderDoQuizComponent } from './components/quiz-practive/header-do-quiz/header-do-quiz.component';
import { AngularFireStorageModule } from '@angular/fire/compat/storage';
import { AngularFireModule } from '@angular/fire/compat';
import { FooterDoQuizComponent } from './components/quiz-practive/footer-do-quiz/footer-do-quiz.component';
import { firebaseConfig } from './constant';
import { ToolbarModule } from 'primeng/toolbar';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { JwtModule } from '@auth0/angular-jwt';
import { Page403Component } from './components/page403/page403.component';
import { LeftSidebarComponent } from './components/dashboard/left-sidebar/left-sidebar.component';
import { UserManageComponent } from './components/dashboard/user-manage/user-manage.component';
import { QuizManageComponent } from './components/dashboard/quiz-manage/quiz-manage.component';
import { EarningMoneyComponent } from './components/dashboard/earning-money/earning-money.component';
import { QuizPracticDetailComponent } from './components/quiz-practive/quiz-practic-detail/quiz-practic-detail.component';
import { CarouselModule as PrimeNGCarouselModule } from 'primeng/carousel';
import { DoQuizFriendsComponent } from './components/quiz-practive/do-quiz-friends/do-quiz-friends.component';
import { SkeletonModule } from 'primeng/skeleton';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { DialogModule } from 'primeng/dialog';
import { InputSwitchModule } from 'primeng/inputswitch';
import { TooltipModule } from 'primeng/tooltip';
import { InputTextModule } from 'primeng/inputtext';
import { ProfileUserOrtherComponent } from './components/profile-user-orther/profile-user-orther.component';
import { CreateQuizComponent } from './components/create-quiz/create-quiz.component';
import { EditQuizComponent } from './components/edit-quiz/edit-quiz.component';
import { UserViewListQuizComponent } from './components/user-view-list-quiz/user-view-list-quiz.component';
import { EditApproveQuizComponent } from './components/dashboard/quiz-manage/edit-approve-quiz/edit-approve-quiz.component';
import { PaginatorModule } from 'primeng/paginator';
import { LobbyChallengeComponent } from './components/lobby-challenge/lobby-challenge.component';
import { DoChallengeComponent } from './components/do-challenge/do-challenge.component';
import { TableModule } from 'primeng/table';
import { ViewStaffComponent } from './components/view-staff/view-staff.component';
import { QuizPrivateDetailComponent } from './components/quiz-private-detail/quiz-private-detail.component';
import { ChallengeComponent } from './components/challenge/challenge.component';
import { CreateExamComponent } from './components/create-exam/create-exam.component';
import { ExamManageComponent } from './components/dashboard/exam-manage/exam-manage.component';
import { EditExamComponent } from './components/edit-exam/edit-exam.component';
import { PaymentComponent } from './components/payment/payment.component';
import { CreateQuizStaffComponent } from './components/create-quiz-staff/create-quiz-staff.component';
import { MenuModule } from 'primeng/menu';
import { ProgressBarModule } from 'primeng/progressbar';
import { HistoryComponent } from './components/dashboard/history/history.component';
import { SelectPaymentComponent } from './components/select-payment/select-payment.component';
import { ChallengeDetailComponent } from './components/challenge-detail/challenge-detail.component';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { CreateQuestionComponent } from './components/create-question/create-question.component';
import { ResultPaymentComponent } from './components/result-payment/result-payment.component';
import { TagModule } from 'primeng/tag';
import { ToastModule } from 'primeng/toast';
import { EditQuestionComponent } from './components/edit-question/edit-question.component';
import { QuestionManageComponent } from './components/dashboard/question-manage/question-manage.component';
import { ApproveQuestionComponent } from './components/dashboard/question-manage/approve-question/approve-question.component';
import { YourLibraryComponent } from './components/your-library/your-library.component';
import { EditQuizPrivateComponent } from './components/edit-quiz-private/edit-quiz-private.component';
import { Page404Component } from './components/page404/page404.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    LoginComponent,
    HeaderComponent,
    FooterComponent,
    ContentServiceComponent,
    ForgotpasswordComponent,
    ProfileComponent,
    ContentServiceComponent,
    ModalLoginComponent,
    ContentloginHomeComponent,
    NotificationComponent,
    LoginPageComponent,
    ModalFormComponent,
    DashboardComponent,
    DoQuizPracticeComponent,
    HeaderDoQuizComponent,
    FooterDoQuizComponent,
    Page403Component,
    LeftSidebarComponent,
    UserManageComponent,
    QuizManageComponent,
    EarningMoneyComponent,
    QuizPracticDetailComponent,
    DoQuizFriendsComponent,
    ProfileUserOrtherComponent,
    CreateQuizComponent,
    EditQuizComponent,
    UserViewListQuizComponent,
    EditApproveQuizComponent,
    QuizPrivateDetailComponent,
    LobbyChallengeComponent,
    DoChallengeComponent,
    ViewStaffComponent,
    ChallengeComponent,
    CreateExamComponent,
    CreateQuizStaffComponent,
    ExamManageComponent,
    EditExamComponent,
    PaymentComponent,
    HistoryComponent,
    SelectPaymentComponent,
    ChallengeDetailComponent,
    CreateQuestionComponent,
    ResultPaymentComponent,
    EditQuestionComponent,
    QuestionManageComponent,
    ApproveQuestionComponent,
    YourLibraryComponent,
    EditQuizPrivateComponent,
    Page404Component
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    PrimeNGCarouselModule,
    SkeletonModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    DialogModule,
    ProgressBarModule,
    InputSwitchModule,
    TooltipModule,
    InputTextareaModule,
    FontAwesomeModule,
    ChartModule,
    TableModule,
    MenuModule,
    ToastModule,
    ToolbarModule,
    RippleModule,
    ButtonModule,
    InputTextModule,
    HttpClientModule,
    CarouselModule,
    PaginatorModule,
    TagModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: () => {
          return localStorage.getItem('authToken'); // Lấy JWT từ localStorage
        }
      },
    }),
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireStorageModule,
  ],
  providers: [Title],
  bootstrap: [AppComponent]
})
export class AppModule { }
