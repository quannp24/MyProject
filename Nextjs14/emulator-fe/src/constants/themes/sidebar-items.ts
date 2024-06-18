import { faHourglassEmpty, faRectangleList } from '@fortawesome/free-solid-svg-icons';
import { IconDefinition } from '@fortawesome/fontawesome-svg-core';

const icons: { [key: string]: IconDefinition } = {
    faHourglassEmpty,
    faRectangleList
};

const dashboard = {
    id: 'dashboard',
    title: 'Dashboard',
    url: '/dashboard',
    icon: 'faHourglassEmpty'
};

const detail = {
    id: 'detail',
    title: 'Detail Access Points',
    url: '/dashboard/default',
    icon: 'faRectangleList'
};

export const menuItems = {
    items: [dashboard, detail]
};