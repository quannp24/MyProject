'use client'
import { drawerWidth } from '@/constants/themes/const';
import { Theme, useMediaQuery } from '@mui/material';
import AppBar from '@mui/material/AppBar'
import Box from '@mui/material/Box'
import CssBaseline from '@mui/material/CssBaseline'
import Toolbar from '@mui/material/Toolbar';
import { styled, useTheme } from '@mui/material/styles';
import React, { useEffect, useState } from 'react'
import Header from '../base/Header';
import Sidebar from '../base/Sidebar';
import { useSelector } from "react-redux";
import Loading from '../base/Loading';

interface MainProps {
    theme: Theme,
    open: boolean
}
// styles
const Main = styled('main', {
    shouldForwardProp: (prop) => prop !== 'open'
  })<MainProps>(({ theme, open }) => ({
    ...theme.typography.mainContent,
    ...(!open && {
        borderBottomLeftRadius: 0,
        borderBottomRightRadius: 0,
        transition: theme.transitions.create('margin', {
            easing: theme.transitions.easing.sharp,
            duration: theme.transitions.duration.leavingScreen
        }),
        [theme.breakpoints.up('md')]: {
            marginLeft: -(drawerWidth - 20),
            width: `calc(100% - ${drawerWidth}px)`
        },
        [theme.breakpoints.down('md')]: {
            marginLeft: '20px',
            width: `calc(100% - ${drawerWidth}px)`,
            padding: '16px'
        },
        [theme.breakpoints.down('sm')]: {
            marginLeft: '10px',
            width: `calc(100% - ${drawerWidth}px)`,
            padding: '16px',
            marginRight: '10px'
        }
    }),
    ...(open && {
        transition: theme.transitions.create('margin', {
            easing: theme.transitions.easing.easeOut,
            duration: theme.transitions.duration.enteringScreen
        }),
        marginLeft: 0,
        borderBottomLeftRadius: 0,
        borderBottomRightRadius: 0,
        width: `calc(100% - ${drawerWidth}px)`,
        [theme.breakpoints.down('md')]: {
            marginLeft: '20px'
        },
        [theme.breakpoints.down('sm')]: {
            marginLeft: '10px'
        }
    })
}));

export default function MainLayout({children}:{children: React.ReactNode;}) {
    const theme = useTheme();
    // Handle left drawer
    const [leftDrawerOpened, setLeftDrawerOpened] = useState<boolean>(true);
    const isLoading = useSelector((state:any) => state.loading.isLoading);

    
  return (
    <Box sx={{ display: 'flex' }}>
        {isLoading &&
        <div className={`transition-opacity duration-700 ease-out opacity-100`}>
            <Loading/>
        </div>
        }
        
        <CssBaseline />
        {/* header */}
        <AppBar
            enableColorOnDark
            position="fixed"
            color="inherit"
            elevation={0}
            sx={{
                bgcolor: theme.palette.background.default,
                transition: leftDrawerOpened ? theme.transitions.create('width') : 'none'
            }}
        >
            <Toolbar>
                <Header setLeftDrawerOpened={setLeftDrawerOpened} leftDrawerOpened={leftDrawerOpened} />
            </Toolbar>
        </AppBar>

        {/* drawer */}
        <Sidebar isOpen={leftDrawerOpened} setIsOpen={setLeftDrawerOpened}/>

        {/* main content */}
        <Main theme={theme} open={leftDrawerOpened}>
            {children}
        </Main>
    </Box>
  )
}
