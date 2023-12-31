import { Component, ElementRef, HostListener, Renderer2, ViewChild } from '@angular/core';
import { faSquarePlus, faTrash, faXmark, faRotateLeft } from '@fortawesome/free-solid-svg-icons';
import { QuestionData } from 'src/app/models/question-data.model';
import { ChatgptService } from 'src/app/services/chatgpt.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { v4 as uuidv4 } from 'uuid';

@Component({
  selector: 'app-create-question',
  templateUrl: './create-question.component.html',
  styleUrls: ['./create-question.component.scss'],
  animations: [fadeOutIn, fadeIn]
})
export class CreateQuestionComponent {
  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  radioText: any[] = [];
  categoryList: any[] = [];
  selectedCategoryId: number = 1;
  selectedDifficultyLevel: number = 1;
  timeLimit?: string;
  selectedTypeQuiz: string = "1";
  title: string = '';
  description: string = '';
  image?: string;
  selectedOption: string = '';
  selectedRadioValue: string = '';
  questionText: string = ''
  DifficultyQuestion: any
  correctAnswer: string = "";
  displayTimeLimit: boolean = false;
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultAdd: boolean = false; // biến kết quả add quiz
  showGenModal: boolean = false;//biến hiển thị modal gen ques
  categoryGenQues: number = 1; // biến lựa chọn category gen ques
  numLv1: number = 0; // biến lưu số ques lv 1 muốn gen ra
  numLv2: number = 0;// biến lưu số ques lv 2 muốn gen ra
  undoGenQues: boolean = false; // biến hiển thị button undo gen
  private previousState: any[] = [];
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  questionCreate: QuestionData[] = []
  userId: any
  textQuestion: string = '';// biến lưu câu hỏi genarate
  statusGenAI: number = 0; // biến status result gen ques 0: chưa gen | 1: đang load | 2: gen succ | 3: gen faild

  ///icon
  faSquarePlus = faSquarePlus;
  faTrash = faTrash;
  faXmark = faXmark;
  faRotateLeft = faRotateLeft;

  numberQuestionCreate: any[] = Array(1).fill(null).map((_, index) => { // biến khởi tạo question ui
    return {
      all4question: "",
      difficultyLevel: 1,
      correctAnswer: "",
      messError: "",
      radioTextItems: Array(4).fill(null).map((_, innerIndex) => {
        return {
          radio: { id: "", name: "", value: "" },
          textInput: { id: "", }
        };
      })
    };
  });


  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService,
    private chatgptService: ChatgptService) { }

  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.userId = user.userId
        this.quizDataService.getCategory().subscribe(res => {
          this.categoryList = res.result
        });
      }
    });
  }



  genarateAI() {
    this.statusGenAI = 1;
    if (this.textQuestion && this.textQuestion.length > 0) {
      this.chatgptService.generateQuestion(this.textQuestion).subscribe(
        (response) => {
          const parsedData = JSON.parse(response);
          this.setQuestionRandom(parsedData.questions);
          this.statusGenAI = 2;
        },
        (error) => {
          this.statusGenAI = 3;
          console.error('Lỗi khi genAI question:', error);
        }
      );

    }
  }


  /*
  * Hàm set giá trị question random vào mảng question
  */
  private async setQuestionRandom(ques: any[]) {
    // Kiểm tra nếu ques không có hoặc số lượng ques ít hơn số lượng cần thiết
    if (!ques || ques.length < 1) {
      console.error("Invalid input for setQuestionRandom");
      return;
    }

    for (let i = 0; i < ques.length; i++) {
      const randomQuestion = ques[i];

      const optionsArray = randomQuestion.options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(randomQuestion.correctAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { id: "", name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.numberQuestionCreate.push({
        quesId: randomQuestion.questionId,
        all4question: randomQuestion.questionText || "",
        difficultyLevel: randomQuestion.difficultyLevel || 1,
        correctAnswer: randomQuestion.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
    this.undoGenQues = true;
  }


  /*
  *Hàm xử lý sự kiện xóa các đáp án
  */
  deleteRadioWithText(outerIndex: number, innerIndex: number) {
    this.numberQuestionCreate[outerIndex].radioTextItems.splice(innerIndex, 1);
    if (innerIndex == (this.numberQuestionCreate[outerIndex].correctAnswer - 1))
      this.numberQuestionCreate[outerIndex].correctAnswer = '';
  }


  /*
  *Hàm thêm một đáp án mới
  */
  addRadioTextEmpty(outerIndex: number) {
    const newItem = {
      radio: {
        id: "",
        name: "",
        value: ""
      },
      textInput: {
        id: "",
      }
    };

    this.numberQuestionCreate[outerIndex].radioTextItems.push(newItem);
  }

  /*
  * Hàm thêm câu hỏi trống mới
  */
  addQuestionEmpty() {
    const newQuestion = {
      all4question: "",
      difficultyLevel: 1,
      correctAnswer: "",
      messError: "",
      radioTextItems: Array(4).fill(null).map((_, innerIndex) => {
        return {
          radio: { id: "", name: "", value: "" },
          textInput: { id: "", }
        };
      })
    };
    this.numberQuestionCreate.push(newQuestion);
  }

  /*
  * Hàm xóa question
  */
  deleteQuestion(index: number) {
    this.numberQuestionCreate.splice(index, 1);
  }


  /*
  *Hàm check và hiển thị mess lỗi các trường question
  */
  private updateMessError(question: any): boolean {
    // Kiểm tra nếu cả hai trường all4question và correctAnswer đều trống
    if (!question.all4question) {
      // Nếu all4question trống
      question.messError = "Question text is empty.";
      return false;
    } else if (!question.correctAnswer) {
      // Nếu correctAnswer trống
      question.messError = "Choose the correct answer for the question.";
      return false;
    } else {
      // Nếu không có lỗi, đảm bảo messError được đặt về trạng thái rỗng
      question.messError = "";
      return true;
    }
  }

  /*
 * Hàm check các question
 */
  checkQuestion(): boolean {
    let checkResult = true;
    // Sử dụng hàm kiểm tra trong một vòng lặp hoặc bất kỳ nơi nào cần thiết
    for (let i = 0; i < this.numberQuestionCreate.length; i++) {
      const question = this.numberQuestionCreate[i];
      if (!this.updateMessError(question)) {
        checkResult = false;
      }
    }
    return checkResult
  }

  /*
  * Hàm set lại giá trị corect answer khi tích radio
  */
  onRadioValueChange(m: number, n: number, value: any) {
    // Set correctAnswer for the selected question
    this.numberQuestionCreate[m].correctAnswer = n + 1;
  }


  /*
  * Hàm xử lý thêm mới quiz
  */
  addQuestion() {
    if (this.checkQuestion()) {
      for (let i = 0; i < this.numberQuestionCreate.length; i++) {
        const question = this.numberQuestionCreate[i];

        // Lấy tất cả các textInput names và join chúng thành một chuỗi bằng dấu '|'
        const options = question.radioTextItems
          .map((item: { textInput: { name: any; }; }) => item.textInput.name)
          .join('|');

        // Gán dữ liệu cho mảng questions trong quizData
        this.questionCreate[i] = {
          questionId: 0,
          questionText: question.all4question,
          difficultyLevel: Number(question.difficultyLevel),
          correctAnswer: question.correctAnswer.toString(),
          options: options,
          status: 2,
          userId: this.userId
        };
      }
      this.quizDataService.addQuestion(this.selectedCategoryId, this.questionCreate).subscribe(
        (response: any) => {
          if (response.status) {
            this.showResult = true;
            this.resultAdd = true;
          } else {
            this.showResult = true;
            this.resultAdd = false;
            console.error('Lỗi add question:', response.message);
          }
        },
        (error) => {
          this.showResult = true;
          this.resultAdd = false;
          console.error('Lỗi add question:', error);
        }
      );
    }

  }



  /*
  *Hàm set tên ảnh theo mã guid
  */
  private setImageNameUpdate(): string {
    const newGuid = uuidv4();
    let fileName: string = '';
    if (this.fileImage) {
      if (this.fileImage.type == 'image/jpeg') {
        fileName = newGuid + '.jpg';
      }
      if (this.fileImage.type == 'image/png') {
        fileName = newGuid + '.png';
      }
    }
    return fileName;
  }


  /*
  * Hàm kiểm tra dữ liệu và các trường
  */
  validateInputQuiz(): boolean {
    let checkResult = true;
    if (!this.title || this.title.length < 1) {
      this.messQuiz.title = true;
      checkResult = false;
    } else {
      this.messQuiz.title = false;
    }
    if (!this.description || this.description.length < 100) {
      this.messQuiz.description = true;
      checkResult = false;
    } else {
      this.messQuiz.description = false;
    }
    if (this.selectedTypeQuiz.includes('2') && !this.timeLimit) {
      this.messQuiz.timeLimit = true;
      checkResult = false;
    } else {
      if (this.timeLimit && /^\d+$/.test(this.timeLimit))
        this.messQuiz.timeLimit = false;
    }
    return checkResult;
  }


  /*
  * Hàm show time limit khi thay đổi type quiz
  */
  onQuizTypeChange() {
    if (this.selectedTypeQuiz === "1") {
      this.displayTimeLimit = false;
    } else {
      this.displayTimeLimit = true;
    }
  }

  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
  }

  /*
 * Hàm nhận sự kiện kéo xuống hiện nút scroll
 */
  @HostListener('window:scroll', [])
  onWindowScroll() {
    const scrollPosition = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;

    // Hiển thị nút khi scroll xuống một khoảng nhất định, ví dụ, 200px
    this.showScrollToTopButton = scrollPosition > 300;
  }


  /*
  * Hàm scroll top tự động
  */
  scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' }); // Sử dụng 'smooth' để có hiệu ứng cuộn mượt
  }


  /*
  * Hàm load ảnh
  */
  handleFileInput(event: any) {
    const fileInput = event.target;

    if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();
      this.image = fileInput.files[0].name;
      reader.onload = (e: any) => {
        if (this.imageSlot)
          this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${e.target.result}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
      };
      this.fileImage = fileInput.files[0];
      reader.readAsDataURL(fileInput.files[0]);
    }
  }

}
