



const Class = {
    id: 'class',
    title: 'Class',
    url: '/class',
    icon: 'SiGoogleclassroom'
};

const Room = {
    id: 'room',
    title: 'Room',
    url: '/room',
    icon: 'HiOutlineOfficeBuilding'
};

const Attendance = {
    id: 'attendance',
    title: 'Attendance',
    url: '/attendance',
    icon: 'MdOutlineFactCheck'
};

const Log = {
    id: 'log',
    title: 'Activity Log',
    url: '/activity-log',
    icon: 'FiFileText'
};

const Setting = {
    id: 'setting',
    title: 'Settings',
    url: '/setting',
    icon: 'FiSettings'
};

const Logout = {
    id: 'logout',
    title: 'Logout',
    url: '/logout',
    icon: 'IoMdPower'
};

export const menuItems = {
    items: [Class, Room, Attendance, Log]
};

export const menuItemsCommon = {
    items: [Setting, Logout]
};