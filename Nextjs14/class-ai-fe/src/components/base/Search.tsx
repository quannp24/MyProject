'use client'
import Box from '@mui/material/Box'
import React, { useState } from 'react'
import PopupState, { bindPopper, bindToggle } from 'material-ui-popup-state';
import ButtonBase from '@mui/material/ButtonBase';
import { styled, useTheme } from '@mui/material/styles';
import Avatar from '@mui/material/Avatar';
import { shouldForwardProp } from '@mui/system';
import { IoIosSearch } from "react-icons/io";
import Popper from '@mui/material/Popper';
import { TransitionProps } from '@mui/material/transitions';
import Grow from '@mui/material/Grow';
import Card from '@mui/material/Card';
import Grid from '@mui/material/Grid';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputAdornment from '@mui/material/InputAdornment';
import { IoClose } from "react-icons/io5";
import { HiOutlineAdjustmentsHorizontal } from "react-icons/hi2";



const HeaderAvatarStyle = styled(Avatar, { shouldForwardProp })(({ theme }) => ({
    ...theme.typography.commonAvatar,
    background: '#fff',
    width: '35px',
    height: '35px',
    color: 'inherit',
    '&:hover': {
        background: '#e2eaff'
    }
}));

const PopperStyle = styled(Popper, { shouldForwardProp })(({ theme }) => ({
    zIndex: 1100,
    width: '100%',
    top: '-47px !important',

}));

const OutlineInputStyle = styled(OutlinedInput, { shouldForwardProp })(({ theme }) => ({
    width: 400,
    height: 40,
    marginLeft: 16,
    paddingLeft: 16,
    paddingRight: 16,
    borderColor:'#fff',
    background: '#F5F6FA',
    borderRadius: 30,
    '& .MuiOutlinedInput-root': {
        background:'#F5F6FA',
    },
    '& .MuiInputBase-input': {
        height:'10px',
    },
    '& .MuiOutlinedInput-notchedOutline': {
        borderRadius: 30,
    },
    '& input': {
        background: '#F5F6FA !important',
        paddingLeft: '4px !important'
    },
    [theme.breakpoints.down('lg')]: {
        width: 250
    },
    [theme.breakpoints.down('md')]: {
        width: '100%',
        marginLeft: 4,
        background: '#F5F6FA'
    }
}));


interface PropsMobileSearch{
    value : string,
    setValue: React.Dispatch<React.SetStateAction<string>>,
    popupState : any
  }



const MobileSearch = ({ value, setValue, popupState }: PropsMobileSearch) => {
    const theme = useTheme();

    return (
        <OutlineInputStyle
            id="input-search-header"
            value={value}
            onChange={(e) => setValue(e.target.value)}
            placeholder="Search"
            sx={{
                borderRadius: '8px',
                height:'55px',
                '& .MuiOutlinedInput-notchedOutline': {
                    borderRadius: '8px',
                },
            }}
            startAdornment={
                <InputAdornment position="start">
                    <IoIosSearch  size="1rem" color={theme.palette.grey[500]} />
                </InputAdornment>
            }
            endAdornment={
                <InputAdornment position="end">
                    <ButtonBase sx={{ borderRadius: '12px' }}>
                        <HeaderAvatarStyle variant="rounded">
                            <IoIosSearch  size="1.3rem" />
                        </HeaderAvatarStyle>
                    </ButtonBase>
                    <Box sx={{ ml: 2 }}>
                        <ButtonBase sx={{ borderRadius: '12px' }}>
                            <HeaderAvatarStyle variant="rounded" {...bindToggle(popupState)}>
                                <IoClose  size="1.3rem" />
                            </HeaderAvatarStyle>
                   
                        </ButtonBase>
                    </Box>
                </InputAdornment>
            }
            aria-describedby="search-helper-text"
            inputProps={{ 'aria-label': 'weight' }}
        />
    );
};




const Transition = React.forwardRef(function Transition(
    props: TransitionProps & {
      children: React.ReactElement<any, any>;
    },
    ref: React.Ref<unknown>,
  ) {
    return <Grow ref={ref} {...props} />;
  });

export default function Search() {
    const theme = useTheme();
    const [value, setValue] = useState('');
  return (
    <>
        <Box sx={{ display: { xs: 'block', md: 'none' } }}>
            <PopupState variant="popper" popupId="demo-popup-popper">
                {(popupState) => (
                    <>
                        <Box sx={{ ml: 2 }}>
                            <ButtonBase sx={{ borderRadius: '12px',pointer:'cursor' }}>
                                <HeaderAvatarStyle variant="rounded" {...bindToggle(popupState)}>
                                    <IoIosSearch size={'20px'}/>
                                </HeaderAvatarStyle>
                            </ButtonBase>
                        </Box>
                        <PopperStyle {...bindPopper(popupState)} transition>
                            {({ TransitionProps }) => (
                                <>
                                     <Transition {...TransitionProps}>
                                        <Card
                                            sx={{
                                                background: '#fff',
                                                [theme.breakpoints.down('sm')]: {
                                                    border: 0,
                                                    boxShadow: 'none'
                                                }
                                            }}
                                        >
                                            <Box sx={{ p: 2 }}>
                                                <Grid container alignItems="center" justifyContent="space-between">
                                                    <Grid item xs>
                                                        <MobileSearch value={value} setValue={setValue} popupState={popupState} />
                                                    </Grid>
                                                </Grid>
                                            </Box>
                                        </Card>
                                    </Transition>
                                </>
                            )}
                        </PopperStyle>
                    </>
                )}
            </PopupState>
        </Box>
        <Box sx={{ display: { xs: 'none', md: 'block' } }}>
            <OutlineInputStyle
                id="input-search-header"
                value={value}
                onChange={(e) => setValue(e.target.value)}
                placeholder="Search"
                startAdornment={
                    <InputAdornment position="start">
                        <IoIosSearch size={'20px'}/>
                    </InputAdornment>
                }
                aria-describedby="search-helper-text"
                inputProps={{ 'aria-label': 'weight' }}
            />
        </Box>
    </>
  )
}
