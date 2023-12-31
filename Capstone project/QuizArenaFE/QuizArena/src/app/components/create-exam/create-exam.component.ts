import { Component, ElementRef, Renderer2, ViewChild } from '@angular/core';
import { faSquarePlus, faTrash, faXmark } from '@fortawesome/free-solid-svg-icons';
import { ExamData } from 'src/app/models/exam-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { ExamService } from 'src/app/services/exam-data.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { v4 as uuidv4 } from 'uuid';


@Component({
  selector: 'app-create-exam',
  templateUrl: './create-exam.component.html',
  styleUrls: ['./create-exam.component.scss']
})
export class CreateExamComponent {

  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  selectedQuizId: number = 1;
  selectedTypeExam: string = "1";
  examId: string = '';
  name: string = '';
  description: string = '';
  image?: string;
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultAdd: boolean = false; // biến kết quả add quiz
  examData = {
    examId: '', // Replace with the appropriate default value
    examName: '',
    quizId: 0, // Replace with the appropriate default value
    description: '',
    status: 0, // Replace with the appropriate default value
    examType: 0, // Replace with the appropriate default value
    date: new Date(), // Replace with the appropriate default value
    image: ''
  };
  listQuiz: any
  isLoading:boolean = true // biến loading

  selectedDateTime!: Date;
  ///icon
  faSquarePlus = faSquarePlus
  faTrash = faTrash
  faXmark = faXmark

  constructor(private examService: ExamService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService) { }
  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.examService.getQuizzesByTypeAndStatus().subscribe(res =>{
          this.selectedQuizId = res[0].quizId
          this.listQuiz = res
          this.isLoading = false;
        })
      }
    });
  }


  /*
  * Hàm xử lý thêm mới exam
  */
  addExam() {
      this.examData.examName = this.name
      this.examData.description = this.description
      this.examData.quizId = this.selectedQuizId
      this.examData.examType = Number(this.selectedTypeExam)
      this.examData.date = this.selectedDateTime;
      if (this.fileImage && this.image) {
        const imgName = this.setImageNameUpdate();
        if (imgName && imgName.trim().length > 0)
        this.examData.image = ` image/challenge/` + imgName;
      }

      console.log(this.examData)

      this.examService.addExam(this.examData).subscribe(
        (response: any) => {
          if (response.status) {
            if (this.fileImage && this.examData.image) {
              this.fireBase.uploadImageQuiz(this.fileImage, this.examData.image);
            }
            this.showResult = true;
            this.resultAdd = true;
          } else {
            this.showResult = true;
            this.resultAdd = false;
            console.error('Lỗi add exam:', response.message);
          }
        },
        (error: any) => {
          this.showResult = true;
          this.resultAdd = false;
          console.error('Lỗi add exam:', error);
        }
      );
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
  // validateInputQuiz(): boolean {
  //   let checkResult = true;
  //   if (!this.title || this.title.length < 1) {
  //     this.messQuiz.title = true;
  //     checkResult = false;
  //   } else {
  //     this.messQuiz.title = false;
  //   }
  //   if (!this.description || this.description.length < 100) {
  //     this.messQuiz.description = true;
  //     checkResult = false;
  //   } else {
  //     this.messQuiz.description = false;
  //   }
  //   if (this.selectedTypeQuiz.includes('2') && !this.timeLimit) {
  //     this.messQuiz.timeLimit = true;
  //     checkResult = false;
  //   } else {
  //     if (this.timeLimit && /^\d+$/.test(this.timeLimit))
  //       this.messQuiz.timeLimit = false;
  //   }
  //   return checkResult;
  // }


  /*
  * Hàm show time limit khi thay đổi type quiz
  */
  // onQuizTypeChange() {
  //   if (this.selectedTypeQuiz === "1") {
  //     this.displayTimeLimit = false;
  //   } else {
  //     this.displayTimeLimit = true;
  //   }
  // }

  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
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
