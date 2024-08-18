import React from 'react';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from 'next/link';
import Typography from '@mui/material/Typography';
import { FaChevronRight } from "react-icons/fa6";
import { useSelector } from 'react-redux';

const CustomBreadcrumbs = () => {
  const breadcrumbs: BreadCrumbs[] = useSelector((state: any) => state.breadcrumbs.breadcrumbs);
  
  return (
    <Breadcrumbs aria-label="breadcrumb" separator={<FaChevronRight fontSize="10px" />}>
      {breadcrumbs.map((breadcrumb, index) => (
        <Link 
          key={index} 
          href={breadcrumb.href} 
          passHref 
          style={{ textDecoration: 'none', color: index === breadcrumbs.length - 1 ? 'text.primary' : 'inherit' }}
        >
          {index === breadcrumbs.length - 1 ? (
            <Typography variant='h2' color="text.primary">{breadcrumb.label}</Typography>
          ) : (
            breadcrumb.label
          )}
        </Link>
      ))}
    </Breadcrumbs>
  );
};

export default CustomBreadcrumbs;
