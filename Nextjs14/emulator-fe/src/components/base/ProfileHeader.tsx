import Avatar from '@mui/material/Avatar';
import Chip from '@mui/material/Chip'
import Grid from '@mui/material/Grid';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Popper from '@mui/material/Popper';
import {  useTheme } from '@mui/material/styles';
import React, { useRef, useState } from 'react'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGear} from '@fortawesome/free-solid-svg-icons';
import Paper from '@mui/material/Paper';
import ClickAwayListener from '@mui/material/ClickAwayListener';
import MainCard from '@/styles/mui-custom/MainCard';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import PerfectScrollbar from 'react-perfect-scrollbar';
import List from '@mui/material/List';
import { TransitionProps } from '@mui/material/transitions';
import Grow from '@mui/material/Grow';
import { IoSettingsOutline } from "react-icons/io5";



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

  return (
    <>
        <Chip
            sx={{
                height: '48px',
                alignItems: 'center',
                borderRadius: '27px',
                transition: 'all .2s ease-in-out',
                borderColor: theme.palette.primary.light,
                backgroundColor: theme.palette.primary.light,
                '&[aria-controls="menu-list-grow"], &:hover': {
                    borderColor: theme.palette.primary.main,
                    background: `${theme.palette.primary.main}!important`,
                    color: theme.palette.primary.light,
                    '& svg': {
                        stroke: theme.palette.primary.light
                    }
                },
                '& .MuiChip-label': {
                    lineHeight: 0
                }
            }}
            icon={
                <Avatar
                    src='images/avatar.png'
                    sx={{
                        ...theme.typography.mediumAvatar,
                        margin: '8px 0 8px 8px !important',
                        cursor: 'pointer'
                    }}
                    ref={anchorRef}
                    aria-controls={open ? 'menu-list-grow' : undefined}
                    aria-haspopup="true"
                    color="inherit"
                />
            }
            label={<IoSettingsOutline size={'22px'}/>}
            variant="outlined"
            ref={anchorRef}
            aria-controls={open ? 'menu-list-grow' : undefined}
            aria-haspopup="true"
            onClick={handleToggle}
            color="primary"
        />
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
                            <MainCard border={false} elevation={16} content={false} boxShadow shadow={theme.shadows[16]}>
                                <Box sx={{ p: 2 }}>
                                    <Stack>
                                        <Stack direction="row" spacing={0.5} alignItems="center">
                                            <Typography variant="h4">Good Morning,</Typography>
                                            <Typography component="span" variant="h4" sx={{ fontWeight: 400 }}>
                                                Johne Doe
                                            </Typography>
                                        </Stack>
                                        <Typography variant="subtitle2">Project Admin</Typography>
                                    </Stack>
                                    <Divider />
                                </Box>
                                <PerfectScrollbar
                                    style={{
                                        height: '100%',
                                        maxHeight: 'calc(100vh - 250px)',
                                        overflowX: 'auto'
                                    }}
                                >
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
                                                    <FontAwesomeIcon size='sm' icon={faGear} />
                                                </ListItemIcon>
                                                <ListItemText primary={<Typography variant="body2">Account Settings</Typography>} />
                                            </ListItemButton>

                                            <ListItemButton
                                                sx={{
                                                    borderRadius: `20px`
                                                }}
                                                selected={selectedIndex === 1}
                                                onClick={(event) => handleListItemClick(event, 1, '#')}
                                            >
                                                <ListItemIcon>
                                                    <FontAwesomeIcon size='sm' icon={faGear} />
                                                </ListItemIcon>
                                                <ListItemText
                                                    primary={
                                                        <Grid container spacing={1} justifyContent="space-between">
                                                            <Grid item>
                                                                <Typography variant="body2">Social Profile</Typography>
                                                            </Grid>
                                                            <Grid item>
                                                                <Chip
                                                                    label="02"
                                                                    size="small"
                                                                    sx={{
                                                                        bgcolor: theme.palette.warning.dark,
                                                                        color: theme.palette.background.default
                                                                    }}
                                                                />
                                                            </Grid>
                                                        </Grid>
                                                    }
                                                />
                                            </ListItemButton>

                                            <ListItemButton
                                                sx={{
                                                    borderRadius: `20px`
                                                }}
                                                selected={selectedIndex === 4}
                                            >
                                                <ListItemIcon>
                                                    <FontAwesomeIcon size='sm' icon={faGear} />
                                                </ListItemIcon>
                                                <ListItemText primary={<Typography variant="body2">Logout</Typography>} />
                                            </ListItemButton>

                                        </List>
                                    </Box>
                                    
                                </PerfectScrollbar>
                            </MainCard>
                        </ClickAwayListener>
                    </Paper>
                </Box>
            </Transition>
            )}
             
        </Popper>
    </>
  )
}
