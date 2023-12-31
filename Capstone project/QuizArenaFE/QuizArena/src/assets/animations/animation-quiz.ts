import { trigger, state, style, animate, transition, keyframes } from '@angular/animations';

export const fadeOutIn = trigger('fadeOutIn', [
  state('void', style({ opacity: 0 })),
  state('*', style({ opacity: 1 })),
  transition(':leave', [
    animate('0.5s ease-out', style({ opacity: 0 }))
  ]),
  transition(':enter', [
    animate('0.5s ease-in', style({ opacity: 1 }))
  ])
]);

export const fadeIn = trigger('fadeIn', [
  state('void', style({ opacity: 0 })),
  state('*', style({ opacity: 1 })),
  transition(':enter', [
    animate('0.5s ease-in', style({ opacity: 1 }))
  ])
]);

export const slideInFromBottomMess = trigger('slideInFromBottomMess', [
  state('void', style({ transform: 'translateY(8px)', opacity: 0 })),
  state('*', style({ transform: 'translateY(0)', opacity: 1 })),
  transition(':enter', [
    animate('0.3s ease-in')
  ])
]);

export const slideInFromBottom = trigger('slideInFromBottom', [
  state('void', style({ transform: 'translateY(15px)', opacity: 0 })),
  state('*', style({ transform: 'translateY(0)', opacity: 1 })),
  transition(':enter', [
    animate('0.5s ease-in')
  ])
]);

export const fadeInOut = trigger('fadeInOut', [
  state('in', style({ opacity: 1, transform: 'translateX(0)' })), // Change 'translateY' to 'translateX'
  transition('void => *', [
    style({ opacity: 0, transform: 'translateX(-100%)' }),
    animate(300)
  ]),
  transition('* => void', [
    animate(300, style({ opacity: 0, transform: 'translateX(-100%)' })) // Change 'translateY' to 'translateX'
  ])
]);

export const fadeInOverflow = trigger('fadeInOverflow', [
  state('void', style({
    opacity: 0,
    transform: 'scale(0)',
    'transform-origin': 'left bottom'  // Đặt vị trí xuất phát ở góc trái dưới
  })),
  transition('void => *', [
    animate('500ms ease-out')
  ]),
]);
