import Avatar from '@mui/material/Avatar'
import Box from '@mui/material/Box'
import ButtonBase from '@mui/material/ButtonBase'
import { useTheme } from '@mui/material/styles';
import React from 'react'
import { faBars} from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import LogoSection from './Logo';
import ProfileHeader from './ProfileHeader';

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
    <>
      <Box
          sx={{
              width: 228,
              display: 'flex',
              [theme.breakpoints.down('md')]: {
                  width: 'auto'
              }
          }}
      >
          <Box component="span" sx={{ display: { xs: 'none', md: 'block' }, flexGrow: 1 }}>
              <LogoSection />
          </Box>
          <ButtonBase sx={{ borderRadius: '12px', overflow: 'hidden' }}>
              <Avatar
                  variant="rounded"
                  sx={{
                      ...theme.typography.commonAvatar,
                      ...theme.typography.mediumAvatar,
                      transition: 'all .2s ease-in-out',
                      background: theme.palette.secondary.light,
                      color: theme.palette.secondary.dark,
                      '&:hover': {
                          background: theme.palette.secondary.dark,
                          color: theme.palette.secondary.light
                      }
                  }}
                  onClick={handleLeftDrawerToggle}
                  color="inherit"
              >
                <FontAwesomeIcon icon={faBars} size='sm'/>
              </Avatar>
          </ButtonBase>
      </Box>

      {/* header search */}
      {/* <SearchSection /> */}
      <Box sx={{ flexGrow: 1 }} />
      <Box sx={{ flexGrow: 1 }} />

      <ProfileHeader/>

            
    </>
  )
}
