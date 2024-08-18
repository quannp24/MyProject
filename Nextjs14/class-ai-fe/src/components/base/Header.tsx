import Avatar from '@mui/material/Avatar'
import Box from '@mui/material/Box'
import ButtonBase from '@mui/material/ButtonBase'
import { useTheme } from '@mui/material/styles';
import React from 'react'
import LogoSection from './Logo';
import ProfileHeader from './ProfileHeader';
import { HiBars3 } from "react-icons/hi2";
import Search from './Search';

interface PropsHeader{
  setLeftDrawerOpened : React.Dispatch<React.SetStateAction<boolean>>,
  leftDrawerOpened: boolean
}

export default function Header({setLeftDrawerOpened, leftDrawerOpened}:PropsHeader) {
  const theme = useTheme();
  const handleLeftDrawerToggle = async () => {
    setLeftDrawerOpened(!leftDrawerOpened);
  }
  return (
    <Box
      sx={{
        display: 'flex',
        alignItems: 'center',
        width: '100%', 
      }}
    >

      {/* Button Base */}
      <ButtonBase
        sx={{ 
          borderRadius: '8px', 
          overflow: 'hidden',
          marginLeft:'20px', 
          padding:'6px',
          '&:hover': {
           background: '#e2eaff',
           transitionDuration:'500ms'
          }
         }}
        onClick={handleLeftDrawerToggle}
      >
        <HiBars3 size='20px' />
      </ButtonBase>

      {/* Header Search */}
      <Search />

      {/* Các Box phân cách */}
      <Box sx={{ flexGrow: 1 }} />
      <Box sx={{ flexGrow: 1 }} />

      {/* Profile Header */}
      <ProfileHeader />

    </Box>
  )
}