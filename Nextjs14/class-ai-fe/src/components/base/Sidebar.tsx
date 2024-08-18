'use client'
import { drawerWidth } from '@/constants/themes/const';
import Box from '@mui/material/Box'
import Drawer from '@mui/material/Drawer'
import { duration, useTheme } from '@mui/material/styles';
import useMediaQuery from '@mui/material/useMediaQuery';
import React, { useEffect, useState } from 'react'
import { BrowserView, MobileView } from 'react-device-detect';
import PerfectScrollbar from 'react-perfect-scrollbar';
import MenuList from '../layout/Menulist';
import LogoSection from './Logo';


interface PropsSidebar{
  setIsOpen : React.Dispatch<React.SetStateAction<boolean>>,
  isOpen: boolean
}

export default function Sidebar({isOpen,setIsOpen}:PropsSidebar) {
  const theme = useTheme();
  const matchUpMd = useMediaQuery(theme.breakpoints.up('md'));
  const [container, setContainer] = useState<HTMLElement | undefined>(undefined);

  useEffect(() => {
    if (typeof window !== 'undefined') {
      setContainer(window.document.body);
    }
  }, []);

  return (
    <div className='relative'>
    {isOpen && !matchUpMd && (
      <div
        className='fixed inset-0 bg-black opacity-50 z-10'
        onClick={() => setIsOpen(false)}
      />
    )}

    <Box
      sx={{
        [theme.breakpoints.down('md')]: {
          width: '15rem',
          position: 'fixed',
          top: 0,
          left: 0,
          height: '100%',
          zIndex: 20,
          backgroundColor: 'white',
          transform: isOpen ? 'translateX(0)' : 'translateX(-100%)',
          opacity: isOpen ? 1 : 0,
          transition: 'transform 0.8s ease, opacity 0.8s ease',
        },
        [theme.breakpoints.up('md')]: {
          width: isOpen ? '15rem' : '4.3rem',
          display: 'flex',
          position: 'static',
          height: 'auto',
          zIndex: 10,
        },
      }}
      className={` duration-300 ${isOpen?'':'p-3'}  pt-4 h-full flex-col bg-white-gray shadow-sm`}
    >
      <div className='flex items-center justify-center'>
        <LogoSection isOpen={isOpen}/>
      </div>

      <BrowserView className="h-full">
        <MenuList isOpen={isOpen} setIsOpen={setIsOpen} isMd={matchUpMd}/>
      </BrowserView>

      <MobileView>
        <Box sx={{ px: 2 }}>
          <MenuList isOpen={isOpen} setIsOpen={setIsOpen} isMd={matchUpMd}/>
          {/* <MenuCard /> */}
        </Box>
      </MobileView>
    </Box>
  </div>
  )
}