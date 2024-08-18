'use client'
import { setLoading } from '@/libs/redux/loadingSlice';
import React, { useEffect } from 'react'
import { useDispatch } from 'react-redux';

export default function page() {
    const dispatch = useDispatch();

    useEffect(() => {
      dispatch(setLoading(false)); 
    }, []);

  return (
    <div>page</div> 
  )
}
