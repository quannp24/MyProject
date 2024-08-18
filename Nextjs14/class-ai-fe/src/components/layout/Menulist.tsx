'use client'
import { menuItems, menuItemsCommon } from '@/constants/themes/sidebar-items'
import { Box, Divider, List, ListItem, ListItemButton, ListItemIcon, ListItemText } from '@mui/material'
import { AnimatePresence, motion } from 'framer-motion';
import { usePathname, useRouter  } from 'next/navigation';
import React, { useEffect, useState } from 'react'
import { IconType } from 'react-icons';
import { HiBars3 } from 'react-icons/hi2';
import { SiGoogleclassroom } from "react-icons/si";
import { BsBorderAll } from "react-icons/bs";
import { FaListCheck } from "react-icons/fa6";
import { FiFileText } from "react-icons/fi";
import { IoSettingsOutline } from "react-icons/io5";
import { FaPowerOff } from "react-icons/fa6";
import { HiOutlineOfficeBuilding } from "react-icons/hi";
import { MdOutlineFactCheck } from "react-icons/md";
import { FiSettings } from "react-icons/fi";
import { IoMdPower } from "react-icons/io";


interface MenuListProps {
    isOpen: boolean;
    setIsOpen: React.Dispatch<React.SetStateAction<boolean>>;
    isMd : boolean
}

const iconMap: Record<string, IconType> = {
    SiGoogleclassroom,
    HiOutlineOfficeBuilding,
    MdOutlineFactCheck,
    FiFileText,
    FiSettings,
    IoMdPower
};

export default function MenuList({isOpen,setIsOpen, isMd}:MenuListProps) {
    const pathname = usePathname();
    const router = useRouter();
    const [selectedItem, setSelectedItem] = useState('');
  
    useEffect(() => {
      setSelectedItem(pathname);
    }, [pathname]);
  
    const handleItemClick = (path:string) => {
      setSelectedItem(path);
      if(!isMd){
          setIsOpen(false);
      }
      router.push(path);
    };

    return (
        <Box 
        sx={{
            display: 'flex',
            flexDirection: 'column',
            height: 'calc(100vh - 60px)', 
        }}
        >
            <List>
                {menuItems.items.map((item) => {
                    const IconComponent = iconMap[item.icon]; 

                    return (
                        <div className={`${isOpen?'pl-6 pr-6':''} relative`} key={item.id}>
                            {(selectedItem === item.url && isOpen) && 
                                <div className='absolute w-1 bg-blue-500 left-0 h-full rounded-r-[50px]'></div>
                            }
                            <ListItemButton 
                                key={item.id}
                                sx={{
                                    display: isOpen?'':'flex',
                                    justifyContent: isOpen?'':'center',
                                }}
                                selected={selectedItem === item.url}
                                onClick={() => handleItemClick(item.url)}
                            >
                                <ListItemIcon>
                                    {IconComponent && <IconComponent size='18px' />}
                                </ListItemIcon>
                                <AnimatePresence>
                                {isOpen && (
                                    <motion.div
                                        initial={{ opacity: 0, x: -20 }}
                                        animate={{ opacity: 1, x: 0 }}
                                        exit={{ opacity: 0, x: -20 }}
                                        transition={{ duration: 0.2}}
                                    >
                                        <ListItemText primary={item.title} />
                                    </motion.div>
                                )}
                                </AnimatePresence>
                            </ListItemButton>
                        </div>
                    );
                })}

            </List>

            <Box sx={{ marginTop: 'auto' }}>
                {isOpen && <Divider />}
                <List>
                {menuItemsCommon.items.map((item) => {
                    const IconComponent = iconMap[item.icon]; 

                    return (
                        <div className={`${isOpen?'pl-6 pr-6':''} relative`} key={item.id}>
                            {(selectedItem === item.url && isOpen) && 
                                <div className='absolute w-1 bg-blue-500 left-0 h-full rounded-r-[50px]'></div>
                            }
                            <ListItemButton 
                                key={item.id}
                                sx={{
                                    display: isOpen?'':'flex',
                                    justifyContent: isOpen?'':'center',
                                }}
                                selected={selectedItem === item.url}
                                onClick={() => handleItemClick(item.url)}
                            >
                                <ListItemIcon>
                                    {IconComponent && <IconComponent size='18px' />}
                                </ListItemIcon>
                                <AnimatePresence>
                                    {isOpen && (
                                    <motion.div
                                        initial={{ opacity: 0, x: -20 }}
                                        animate={{ opacity: 1, x: 0 }}
                                        exit={{ opacity: 0, x: -20 }}
                                        transition={{ duration: 0.2 }}
                                    >
                                        <ListItemText primary={item.title} />
                                    </motion.div>
                                    )}
                                </AnimatePresence>
                            </ListItemButton>
                        </div>
                      );
                    })}
                </List>
            </Box>

        </Box>
    );
};