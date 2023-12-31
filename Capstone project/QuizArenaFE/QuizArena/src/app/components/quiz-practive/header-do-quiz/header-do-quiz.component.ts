import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSlidersH, faTimes } from '@fortawesome/free-solid-svg-icons';
import { Quiz } from 'src/app/models/quiz-data.model';


@Component({
  selector: 'app-header-do-quiz',
  templateUrl: './header-do-quiz.component.html',
  styleUrls: ['./header-do-quiz.component.scss']
})
export class HeaderDoQuizComponent {
  @Output() showOptionsEvent = new EventEmitter<void>();
  @Input() quizData?: Quiz;
  quizId?: number;



  //icon
  faSlidersH = faSlidersH;
  faTimes = faTimes;

  constructor(public routerDirect: Router, private route: ActivatedRoute) {

  }

  showOptions() {
    this.showOptionsEvent.emit();
  }


  backDetail() {
    this.route.params.subscribe(params => {
      this.quizId = params['quizId']; // Lấy giá trị quizId từ đường dẫn
    });
    if (this.quizData?.quizType != 3) {
      this.routerDirect.navigate(['/quiz-detail/' + this.quizId]);
    } else {
      this.routerDirect.navigate(['/quiz-private-detail/' + this.quizId]);

    }
  }
}
