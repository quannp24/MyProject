import React, { useEffect } from 'react'
import { useLocation } from 'react-router-dom';
import PropTypes from 'prop-types';


//Giúp khi chuyển component scroll sẽ tự động lên đầu
function NavigationScroll({
    children,
  }: Readonly<{
    children: React.ReactNode;
  }>) {
    const location = useLocation();
    const { pathname } = location;

    useEffect(() => {
        window.scrollTo({
            top: 0,
            left: 0,
            behavior: 'smooth'
        });
    }, [pathname]);

    return children || null;
}

NavigationScroll.propTypes = {
    children: PropTypes.node
};

export default NavigationScroll;