import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { LoginPageComponent } from './components/login/login-page/login-page.component';
import { ProfileComponent } from './components/profile/profile.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { DoQuizPracticeComponent } from './components/quiz-practive/do-quiz-practice/do-quiz-practice.component';
import { AuthRouteService } from './services/auth-route.service';
import { Page403Component } from './components/page403/page403.component';
import { UserManageComponent } from './components/dashboard/user-manage/user-manage.component';
import { QuizManageComponent } from './components/dashboard/quiz-manage/quiz-manage.component';
import { EarningMoneyComponent } from './components/dashboard/earning-money/earning-money.component';
import { QuizPracticDetailComponent } from './components/quiz-practive/quiz-practic-detail/quiz-practic-detail.component';
import { DoQuizFriendsComponent } from './components/quiz-practive/do-quiz-friends/do-quiz-friends.component';
import { ProfileUserOrtherComponent } from './components/profile-user-orther/profile-user-orther.component';
import { CreateQuizComponent } from './components/create-quiz/create-quiz.component';
import { EditQuizComponent } from './components/edit-quiz/edit-quiz.component';
import { UserViewListQuizComponent } from './components/user-view-list-quiz/user-view-list-quiz.component';
import { EditApproveQuizComponent } from './components/dashboard/quiz-manage/edit-approve-quiz/edit-approve-quiz.component';
import { ViewStaffComponent } from './components/view-staff/view-staff.component';
import { ChallengeComponent } from './components/challenge/challenge.component';
import { CreateExamComponent } from './components/create-exam/create-exam.component';
import { ExamManageComponent } from './components/dashboard/exam-manage/exam-manage.component';
import { EditExamComponent } from './components/edit-exam/edit-exam.component';
import { PaymentComponent } from './components/payment/payment.component';
import { DoChallengeComponent } from './components/do-challenge/do-challenge.component';
import { LobbyChallengeComponent } from './components/lobby-challenge/lobby-challenge.component';
import { HistoryComponent } from './components/dashboard/history/history.component';
import { SelectPaymentComponent } from './components/select-payment/select-payment.component';
import { ChallengeDetailComponent } from './components/challenge-detail/challenge-detail.component';
import { ResultPaymentComponent } from './components/result-payment/result-payment.component';
import { CreateQuestionComponent } from './components/create-question/create-question.component';
import { EditQuestionComponent } from './components/edit-question/edit-question.component';
import { QuestionManageComponent } from './components/dashboard/question-manage/question-manage.component';




import { CreateQuizStaffComponent } from './components/create-quiz-staff/create-quiz-staff.component';
import { QuizPrivateDetailComponent } from './components/quiz-private-detail/quiz-private-detail.component';
import { ApproveQuestionComponent } from './components/dashboard/question-manage/approve-question/approve-question.component';
import { YourLibraryComponent } from './components/your-library/your-library.component';
import { EditQuizPrivateComponent } from './components/edit-quiz-private/edit-quiz-private.component';
import { Page404Component } from './components/page404/page404.component';

const routes: Routes = [
  { path: 'home', component: HomeComponent }, // Trang chủ
  { path: 'login', component: LoginPageComponent }, // đăng nhập
  { path: 'profile-orther/:friendId', component: ProfileUserOrtherComponent },
  { path: 'quiz-private-detail/:quizId', component: QuizPrivateDetailComponent },

  { path: 'list-quiz', component: UserViewListQuizComponent },

  { path: 'challenge', component: ChallengeComponent },
  { path: 'challenge-detail/:examId', component: ChallengeDetailComponent },
  {
    path: 'your-library',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: YourLibraryComponent
  },
  {
    path: 'create-quiz-staff',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3']
    },
    component: CreateQuizStaffComponent
  },
  {
    path: 'result-payment',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: ResultPaymentComponent
  },
  {
    path: 'payment',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: SelectPaymentComponent
  },
  {
    path: 'approve-quiz/:quizId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3']
    },
    component: EditApproveQuizComponent
  },
  {
    path: 'staff-view',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3']
    },
    component: ViewStaffComponent
  },
  {
    path: 'create-challenge',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: CreateExamComponent
  },
  {
    path: 'challenge-manage',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: ExamManageComponent
  },
  {
    path: 'history',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: HistoryComponent
  },
  {
    path: 'do-challenge/:quizId/:examId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: DoChallengeComponent
  },
  {
    path: 'lobby-challenge/:examId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: LobbyChallengeComponent
  },
  {
    path: 'edit-challenge/:examId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: EditExamComponent
  },
  {
    path: 'edit-quiz/:quizId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: EditQuizPrivateComponent
  },
  {
    path: 'edit-quiz-staff/:quizId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '3']
    },
    component: EditQuizComponent
  },
  {
    path: 'edit-question/:categoryId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '3']
    },
    component: EditQuestionComponent
  },
  {
    path: 'approve-question/:categoryId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: ApproveQuestionComponent
  },
  {
    path: 'create-quiz',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: CreateQuizComponent
  },
  {
    path: 'create-question',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '3']
    },
    component: CreateQuestionComponent
  },

  {
    path: 'user-manage',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1']
    },
    component: UserManageComponent
  },
  {
    path: 'quiz-manage',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: QuizManageComponent
  },
  {
    path: 'question-manage',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: QuestionManageComponent
  },
  {
    path: 'earning-money',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: EarningMoneyComponent
  },
  {
    path: 'profile',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: ProfileComponent
  },
  {
    path: 'dashboard',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2']
    },
    component: DashboardComponent
  },
  {
    path: 'do-quiz/:quizId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: DoQuizPracticeComponent
  },
  {
    path: 'do-quiz-friends/:quizId/:roomId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '5']
    },
    component: DoQuizFriendsComponent
  },
  {
    path: 'quiz-detail/:quizId',
    canActivate: [AuthRouteService],
    data: {
      expectedRole: ['1', '2', '3', '4', '5']
    },
    component: QuizPracticDetailComponent
  },
  { path: '403page', component: Page403Component },
  { path: '', redirectTo: '/home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
