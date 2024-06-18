'use client'
import { drawerWidth } from '@/constants/themes/const';
import Box from '@mui/material/Box'
import Drawer from '@mui/material/Drawer'
import { useTheme } from '@mui/material/styles';
import useMediaQuery from '@mui/material/useMediaQuery';
import React, { useEffect, useState } from 'react'
import { BrowserView, MobileView } from 'react-device-detect';
import PerfectScrollbar from 'react-perfect-scrollbar';
import MenuList from '../layout/Menulist';


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
  const handleCloseSidebar = async () => {
    setIsOpen(false);
  }
  return (
    <Box component="nav" sx={{ flexShrink: { md: 0 }, width: matchUpMd ? drawerWidth : 'auto' }} aria-label="mailbox folders">
            <Drawer
                container={container}
                variant={matchUpMd ? 'persistent' : 'temporary'}
                anchor="left"
                open={isOpen}
                onClose={handleCloseSidebar}
                sx={{
                    '& .MuiDrawer-paper': {
                        width: drawerWidth,
                        background: theme.palette.background.default,
                        color: theme.palette.text.primary,
                        borderRight: 'none',
                        [theme.breakpoints.up('md')]: {
                            top: '88px'
                        }
                    }
                }}
                ModalProps={{ keepMounted: true }}
                color="inherit"
            >
              <div>
                <Box sx={{ display: { xs: 'block', md: 'none' } }}>
                    <Box sx={{ display: 'flex', p: 2, mx: 'auto' }}>
                        {/* <LogoSection /> */}
                    </Box>
                </Box>
                
                <BrowserView>
                    <PerfectScrollbar
                        component="div"
                        style={{
                            height: !matchUpMd ? 'calc(100vh - 56px)' : 'calc(100vh - 88px)',
                            paddingLeft: '16px',
                            paddingRight: '16px'
                        }}
                    >
                        <MenuList />
                        {/* <MenuCard /> */}
                    </PerfectScrollbar>
                </BrowserView>
                
                <MobileView>
                    <Box sx={{ px: 2 }}>
                        <MenuList />
                        {/* <MenuCard /> */}
                    </Box>
                </MobileView>
              </div>
            </Drawer>
        </Box>
  )
}
