import { createTheme } from "@mui/material/styles";
import themePalette from "./palette";
import themeTypography from "./typography";
import componentStyleOverrides from "./componentStyleOverrides";

const theme = () => {
    const color = {
        paper: '#ffffff',
        primaryLight: '#eef2f6',
        primary200: '#90caf9',
        primaryMain: '#2196f3',
        primaryDark: '#1e88e5',
        primary800: '#1565c0',
        secondaryLight: '#ede7f6',
        secondary200: '#b39ddb',
        secondaryMain: '#673ab7',
        secondaryDark: '#4f4f4f',
        secondary800: '#4527a0',
        successLight: '#b9f6ca',
        success200: '#69f0ae',
        successMain: '#00e676',
        successDark: '#00c853',
        errorLight: '#ffbebe52',
        errorMain: '#f44336',
        errorDark: '#ff000052',
        errorText: '#ffcfcf',
        orangeLight: '#ff8e8efc',
        orangeMain: '#ffab91',
        redMain: '#ff4d4d',
        redLight: '#ff8f8f',
        redDark: '#e9b2b282',
        orangeDark: '#d84315',
        warningLight: '#fff8e1',
        warningMain: '#ffe57f',
        warningDark: '#ffc107',
        grey50: '#F8FAFC',
        grey100: '#EEF2F6',
        grey200: '#E3E8EF',
        grey300: '#CDD5DF',
        grey500: '#697586',
        grey600: '#4B5565',
        grey700: '#364152',
        grey900: '#121926',
        darkPaper: '#111936',
        darkBackground: '#1a223f',
        darkLevel1: '#29314f',
        darkLevel2: '#212946',
        darkTextTitle: '#d7dcec',
        darkTextPrimary: '#bdc8f0',
        darkTextSecondary: '#8492c4',
        darkPrimaryLight: '#eef2f6',
        darkPrimaryMain: '#2196f3',
        darkPrimaryDark: '#1e88e5',
        darkPrimary200: '#90caf9',
        darkPrimary800: '#1565c0',
        darkSecondaryLight: '#d1c4e9',
        darkSecondaryMain: '#7c4dff',
        darkSecondaryDark: '#651fff',
        darkSecondary200: '#b39ddb',
        darkSecondary800: '#6200ea',
        blueMain:'#4880FF',
        blueLight:'#e2eaff',
        darkFont:'#202224',
    };

    const themeOption = {
        colors: color,
        heading: color.grey900,
        paper: color.paper,
        backgroundDefault: color.paper,
        background: color.primaryLight,
        darkTextPrimary: color.grey700,
        darkTextSecondary: color.grey500,
        textDark: color.darkFont,
        menuSelected: color.blueMain,
        menuSelectedBack: color.secondaryLight,
        menuHover: color.blueLight,
        divider: color.grey200,
        textTransform : 'capitalize',
        borderRadius: 12,
        fontFamily:`'Nunito-Custom700', sans-serif`
    };

    const themeOptions = {
        palette: themePalette(themeOption),
        mixins: {
            toolbar: {
                minHeight: '48px',
                padding: '16px',
                '@media (min-width: 600px)': {
                    minHeight: '48px'
                }
            }
        },
        typography: themeTypography(themeOption)
    };

    const themes = createTheme(themeOptions); 
    themes.components = componentStyleOverrides(themeOption);

    return themes;
};

export default theme;
