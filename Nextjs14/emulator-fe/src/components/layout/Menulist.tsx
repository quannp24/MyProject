import { menuItems } from '@/constants/themes/sidebar-items'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { List, ListItem, ListItemIcon, ListItemText } from '@mui/material'
import { IconDefinition, faHourglassEmpty, faRectangleList} from '@fortawesome/free-regular-svg-icons';
import React from 'react'

// Map icon names to actual FontAwesome icons
const icons: { [key: string]: IconDefinition } = {
  faHourglassEmpty,
  faRectangleList
};

export default function MenuList() {
    const navItems = menuItems.items.map((item) => {

        return (
          <ListItem key={item.id}>
            <ListItemIcon>
                <FontAwesomeIcon size='xl' icon={icons[item.icon]} />
            </ListItemIcon>
            <ListItemText primary={item.title} />
          </ListItem>
        );
    });

    return (
        <List>
            {navItems}
        </List>
    );
};
