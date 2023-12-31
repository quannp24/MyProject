import { Component } from '@angular/core';
import { faPhoneSquareAlt, faEnvelope } from '@fortawesome/free-solid-svg-icons';
import { faSquareFacebook, faTwitterSquare, faGooglePlusSquare, faInstagramSquare } from '@fortawesome/free-brands-svg-icons';



@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent {
  faPhoneSquareAlt = faPhoneSquareAlt;
  faEnvelope = faEnvelope;
  faSquareFacebook = faSquareFacebook;
  faTwitterSquare = faTwitterSquare;
  faGooglePlusSquare = faGooglePlusSquare;
  faInstagramSquare = faInstagramSquare
}
