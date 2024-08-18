import Avatar from '@mui/material/Avatar';
import Chip from '@mui/material/Chip'
import Grid from '@mui/material/Grid';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Popper from '@mui/material/Popper';
import {  useTheme } from '@mui/material/styles';
import React, { useRef, useState } from 'react'
import Paper from '@mui/material/Paper';
import ClickAwayListener from '@mui/material/ClickAwayListener';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import PerfectScrollbar from 'react-perfect-scrollbar';
import List from '@mui/material/List';
import { TransitionProps } from '@mui/material/transitions';
import Grow from '@mui/material/Grow';
import { IoLogOutOutline, IoSettingsOutline } from "react-icons/io5";
import MainCard from '@/styles/mui-custom/MainCard';
import { GoGear } from "react-icons/go";
import { IoIosArrowDown } from "react-icons/io";
import { TiUserAddOutline } from 'react-icons/ti';



const Transition = React.forwardRef(function Transition(
    props: TransitionProps & {
      children: React.ReactElement<any, any>;
    },
    ref: React.Ref<unknown>,
  ) {
    return <Grow ref={ref} {...props} />;
  });


export default function ProfileHeader() {
    const theme = useTheme();
    const anchorRef = useRef(null);
    const [open, setOpen] = useState(false);
    const [sdm, setSdm] = useState(true);
    const [value, setValue] = useState('');
    const [notification, setNotification] = useState(false);
    const [selectedIndex, setSelectedIndex] = useState(-1);

    const handleToggle = () => {
        setOpen((prevOpen) => !prevOpen);
    };

    const handleClose = () => {
        setOpen(false);
    };

    const handleListItemClick = (event:any, index:number, route:string) => {
        setSelectedIndex(index);
        handleClose();
    };

    const handleLogout = () => {
        console.log('');
        
    };



  return (
    <Box
    sx={{
        marginRight: '30px'
    }}
    >
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
            <Box
                sx={{
                    marginRight: '15px',
                }}
            >
                <Avatar
                        src='images/avatar.jpg'
                        sx={{
                            ...theme.typography.mediumAvatar,
                            cursor: 'pointer'
                        }}
                        
                        aria-controls={open ? 'menu-list-grow' : undefined}
                        aria-haspopup="true"
                        color="inherit"
                    />
            </Box>
            <Box>
                <Typography variant="body2" 
                sx={{ 
                    fontWeight: '600',
                    color: theme.palette.secondary.dark,
                    fontFamily: `'Nunito-Custom700', sans-serif`
                }}
                >
                    Moni Roy
                </Typography>
                <Typography variant="caption" color="textSecondary"
                      sx={{ 
                        fontWeight: '400',
                        color: theme.palette.secondary.dark,
                        fontFamily: `'Nunito-Custom', sans-serif`
                    }}
                >
                    Admin
                </Typography>
            </Box>
            <Box
                sx={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    borderRadius: '50%',
                    border: '2px solid #ccc',
                    padding: '2px',
                    marginLeft: '15px',
                    color:'#4f4f4f',
                    cursor: 'pointer'
                }}
                ref={anchorRef}
                onClick={handleToggle}
            >
                <IoIosArrowDown size={'12px'} />
            </Box>
        </Box>
        <Popper
            placement="top-start"
            open={open}
            anchorEl={anchorRef.current}
            role={undefined}
            transition
            disablePortal
            popperOptions={{
                modifiers: [
                    {
                        name: 'offset',
                        options: {
                            offset: [0, 14]
                        }
                    }
                ]
            }}
        >

        {({ TransitionProps }) => (
            <Transition {...TransitionProps}>
                <Box sx={{transformOrigin:'top left'}}>
                    <Paper sx={{borderRadius:'14px'}}>
                        <ClickAwayListener onClickAway={handleClose}>
                            <MainCard border={false} elevation={16} content={false}  >
                                <Box sx={{ p: 2, paddingBottom:0 }}>
                                    <Stack>
                                        <Stack direction="row" spacing={0.5} alignItems="center">
                                            <Typography component="span" variant="h4" sx={{ fontWeight: 400 }}>
                                                Quan
                                            </Typography>
                                        </Stack>
                                        <Typography variant="subtitle2">Admin</Typography>
                                    </Stack>
                                    <Divider />
                                </Box>
                                <Box sx={{ p: 1 }}>
                                    <List
                                        component="nav"
                                        sx={{
                                            width: '100%',
                                            maxWidth: 350,
                                            minWidth: 300,
                                            backgroundColor: theme.palette.background.paper,
                                            borderRadius: '20px',
                                            [theme.breakpoints.down('md')]: {
                                                minWidth: '100%'
                                            },
                                            '& .MuiListItemButton-root': {
                                                mt: 0.5
                                            }
                                        }}
                                    >
                                        <ListItemButton
                                            sx={{
                                                borderRadius: `20px`
                                            }}
                                            selected={selectedIndex === 0}
                                            onClick={(event) => handleListItemClick(event, 0, '#')}
                                        >
                                            <ListItemIcon>
                                                <TiUserAddOutline size={'22px'}/>
                                            </ListItemIcon>
                                            <ListItemText primary={<Typography variant="body2">Add Account</Typography>} />
                                        </ListItemButton>


                                        <ListItemButton
                                            sx={{
                                                borderRadius: `20px`
                                            }}
                                            selected={selectedIndex === 4}
                                            onClick={handleLogout}
                                        >
                                            <ListItemIcon>
                                                <IoLogOutOutline size={'22px'}/>
                                            </ListItemIcon>
                                            <ListItemText primary={<Typography variant="body2">Logout</Typography>} />
                                        </ListItemButton>

                                    </List>
                                </Box>
                            </MainCard>
                        </ClickAwayListener>
                    </Paper>
                </Box>
            </Transition>
            )}
             
        </Popper>
    </Box>
  )
}