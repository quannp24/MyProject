'use client'
import {useDispatch } from "react-redux";
import theme from "@/styles/mui-theme/theme-common";
import { useEffect } from "react";
import { setBreadcrumbs } from "@/libs/redux/breadcrumbsSlice";
import { Box } from "@mui/material";
import NextBreadcrumbs from "@/components/base/NextBreadcrumbs";


export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  const dispatch = useDispatch();

  useEffect(() => {
    const breadcrumbs: BreadCrumbs[] = [
      { label: 'Class', href: '/class' }
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