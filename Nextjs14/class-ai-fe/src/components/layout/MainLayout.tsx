'use client'
import { drawerWidth, gridSpacing } from '@/constants/themes/const';
import { Avatar, ButtonBase, Grid, Theme, useMediaQuery } from '@mui/material';
import AppBar from '@mui/material/AppBar'
import Box from '@mui/material/Box'
import CssBaseline from '@mui/material/CssBaseline'
import Toolbar from '@mui/material/Toolbar';
import { styled, useTheme } from '@mui/material/styles';
import React, { useEffect, useState } from 'react'
import Header from '../base/Header';
import { useSelector } from "react-redux";
import Loading from '../base/Loading';
import Sidebar from '../base/Sidebar';
import { HiBars3 } from "react-icons/hi2";


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
            marginLeft: -(drawerWidth - 120),
            width: `calc(100% - ${drawerWidth}px)`,
            boxShadow: ' 5px 10px #888888'
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
    const handleLeftDrawerToggle = async () => {
        setLeftDrawerOpened(!leftDrawerOpened);
      }
    
  return (
    <div className="flex h-screen w-screen relative antialiased bg-gray-light">

            {isLoading &&
                <div className={`transition-opacity duration-700 ease-out ${isLoading ? 'opacity-100' : 'opacity-0'}`}>
                    <Loading/>
                </div>
            }

            <div className="flex flex-shrink-0 transition-all">
              <Sidebar isOpen={leftDrawerOpened} setIsOpen={setLeftDrawerOpened}/>
            </div>

            <div className=" max-h-screen w-full bg-[#F5F6FA]">
            <Grid container sx={{overflow:'hidden', height:'100%'}}>
                <Grid item xs={12} className='bg-white h-[60px] flex items-center'>
                    <Header leftDrawerOpened={leftDrawerOpened} setLeftDrawerOpened={setLeftDrawerOpened}/>
                </Grid>

                <Grid item xs={12} className='h-full'>
                    {children}
                </Grid>
            </Grid>
            
            </div>

        </div>
  )
}