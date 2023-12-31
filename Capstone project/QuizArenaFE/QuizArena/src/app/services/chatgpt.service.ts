import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, from, map } from 'rxjs';
import OpenAI from 'openai';

@Injectable({
  providedIn: 'root'
})
export class ChatgptService {
  private openai: OpenAI;


  constructor() {
    this.openai = new OpenAI({ apiKey: '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', dangerouslyAllowBrowser: true });
  }

  generateQuestion(prompt: string): Observable<string> {
    const textChat = prompt+ ` bằng tiếng Anh và cho các đáp án lựa chọn, chỉ vị trí đáp án đúng theo format json sau:
    {
      "questions": [
        {
          "questionText": nội dung câu hỏi,
          "difficultyLevel": mức độ câu hỏi có thể là 1 hoặc 2,
          "correctAnswer": ví trí đáp án đúng ví dụ A là 1, B là 2 và C là 3,
          "options": là các đáp án được nối với nhau và ngăn cách bởi dấu | , không cần ghi A B C ở đầu
        }
      ]
    }`
    return from(this.openai.chat.completions.create({ model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: textChat }] }))
      .pipe(
        map(response => response.choices[0]?.message?.content || '')
      );
  }


}
