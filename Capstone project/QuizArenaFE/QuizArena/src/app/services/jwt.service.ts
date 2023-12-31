import { Injectable } from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class JwtService {
  constructor(public jwtHelper: JwtHelperService) { }

  public checkTokenExpired(token: string): boolean { // het han return true, chua het han return false
    return this.jwtHelper.isTokenExpired(token);
  }

  public getRoleToken(token: string): string |null {
    const decodedToken = this.jwtHelper.decodeToken(token);

    if (decodedToken && decodedToken.hasOwnProperty('role')) {
      const role = decodedToken['role'];
      return role;
    }

    return null;
  }
}
