'use client'
import { setLoading } from '@/libs/redux/loadingSlice';
import React, { useEffect } from 'react'
import { useDispatch } from 'react-redux';

export default function DashboardPage() {
  const dispatch = useDispatch();

  useEffect(() => {

    dispatch(setLoading(false)); 
   
  }, []);

  return (
    <div className='h-full w-full'>
      <div className='h-full w-full'> 
        hello
      </div>
    </div>
  )
}
