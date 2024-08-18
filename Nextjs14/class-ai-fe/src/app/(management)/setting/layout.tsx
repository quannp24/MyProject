'use client'
import NextBreadcrumbs from "@/components/base/NextBreadcrumbs";
import { setBreadcrumbs } from "@/libs/redux/breadcrumbsSlice";
import theme from "@/styles/mui-theme/theme-common";
import { Box } from "@mui/material";
import { useEffect } from "react";
import { useDispatch } from "react-redux";


export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const dispatch = useDispatch();

  useEffect(() => {
    const breadcrumbs: BreadCrumbs[] = [
      { label: 'Settings', href: '/setting' }
    ];
    dispatch(setBreadcrumbs(breadcrumbs));
  }, [dispatch]);

  return (
    <Box
      sx={{
        padding:'20px'
      }}
    >
      <Box mb={2}>
        <NextBreadcrumbs/>
      </Box>
      <Box>
        {children}
      </Box>
    </Box>
  );
}