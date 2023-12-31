import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router } from '@angular/router';
import { JwtService } from './jwt.service';

@Injectable({
  providedIn: 'root'
})
export class AuthRouteService implements CanActivate {

  constructor(public jwtService: JwtService, public router: Router) { }

  canActivate(route: ActivatedRouteSnapshot): boolean {
    const expectedRoles: string[] = route.data["expectedRole"];
    const token = localStorage.getItem('authToken');
    if (token) {
      if (this.jwtService.checkTokenExpired(token.toString())) {
        this.router.navigate(['/login']);
        return false;
      } else {
        const role = this.jwtService.getRoleToken(token.toString());
        if (role && !expectedRoles.includes(role?.toString())) {
          this.router.navigate(['/403page']);
          return false;
        } else {
          return true;
        }
      }
    } else {
      this.router.navigate(['/login']);
      return false;
    }
  }
}
