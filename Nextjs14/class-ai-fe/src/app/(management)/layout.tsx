'use client'
import { CssBaseline, StyledEngineProvider, ThemeProvider } from "@mui/material";
import MainLayout from "@/components/layout/MainLayout";
import { Provider } from "react-redux";
import { store } from "@/libs/redux/store";
import theme from "@/styles/mui-theme/theme-common";


export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const appTheme = theme();

  return (
    <StyledEngineProvider injectFirst>
        <ThemeProvider theme={appTheme}>
            <Provider store={store}>
                <CssBaseline />
                <MainLayout>{children}</MainLayout>
            </Provider>
        </ThemeProvider>
    </StyledEngineProvider>
  );
}