import { createTheme } from '@mui/material/styles';

const themeMUIExample = createTheme({
    components: {
        MuiInputBase: {
            styleOverrides: {
                root: {
                    borderRadius: '13px 14px',
                    height: '3rem',
                    border: 'none',
                },
            },
        },
        MuiOutlinedInput: {
            styleOverrides: {
                root: {
                    padding: '8px',
                    ":hover": {
                        borderColor: "transparent",
                    },
                    '&:hover .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#e1e1e1',
                    },
                    "&.Mui-focused .MuiOutlinedInput-notchedOutline": {
                        borderColor: 'black',
                    },
                },
                notchedOutline: {
                    '&.Mui-focused': {
                        borderColor: "#e1e1e1",
                    },
                    '&:hover': {
                        borderColor: "transparent",
                    },
                    borderColor: "#e1e1e1",
                },
            },
        },
    },
});

export default themeMUIExample;
