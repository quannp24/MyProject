import '@mui/material/styles';

declare module '@mui/material/styles' {
  interface TypographyVariants {
    mainContent: React.CSSProperties;
    commonAvatar: React.CSSProperties;
    mediumAvatar: React.CSSProperties;
    largeAvatar: React.CSSProperties;
    smallAvatar: React.CSSProperties;
  }

  interface TypographyVariantsOptions {
    mainContent?: React.CSSProperties;
    commonAvatar?: React.CSSProperties;
    mediumAvatar?: React.CSSProperties;
    largeAvatar?: React.CSSProperties;
    smallAvatar?: React.CSSProperties;
  }
}

declare module '@mui/material/Typography' {
  interface TypographyPropsVariantOverrides {
    mainContent: true,
    commonAvatar:true,
    mediumAvatar:true,
    largeAvatar:true,
    smallAvatar:true,
  }
}