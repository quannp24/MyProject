import React, { forwardRef } from 'react';
import { Card, CardHeader, CardContent, Divider, Typography, useTheme } from '@mui/material';
import { SxProps, Theme } from '@mui/system';

interface MainCardProps {
    border?: boolean;
    boxShadow?: boolean;
    children: React.ReactNode;
    content?: boolean;
    contentClass?: string;
    contentSX?: SxProps<Theme>;
    darkTitle?: boolean;
    secondary?: React.ReactNode | string;
    shadow?: string;
    sx?: SxProps<Theme>;
    title?: React.ReactNode | string;
    [key: string]: any;
}

const MainCard = forwardRef<HTMLDivElement, MainCardProps>(({
    border = true,
    boxShadow,
    children,
    content = true,
    contentClass = '',
    contentSX = {},
    darkTitle,
    secondary,
    shadow,
    sx = {},
    title,
    ...others
}, ref) => {
    const theme = useTheme();

    return (
        <Card
            ref={ref}
            {...others}
            sx={{
                borderRadius: '14px',
                border: border ? '1px solid' : 'none',
                borderColor:  '#b39ddb',
                ':hover': {
                    boxShadow: boxShadow ? shadow || '0 2px 14px 0 rgb(32 40 45 / 8%)' : 'inherit'
                },
                
                ...sx
            }}
        >
            {/* card header and action */}
            {title && (
                <CardHeader
                    title={darkTitle ? <Typography variant="h3">{title}</Typography> : title}
                    action={secondary}
                />
            )}

            {/* content & header divider */}
            {title && <Divider />}

            {/* card content */}
            {content && (
                <CardContent sx={contentSX} className={contentClass}>
                    {children}
                </CardContent>
            )}
            {!content && children}
        </Card>
    );
});

MainCard.displayName = 'MainCard';

export default MainCard;
