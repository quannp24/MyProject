import ButtonBase from '@mui/material/ButtonBase'
import React from 'react'
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';

export default function LogoSection({isOpen}:{isOpen:boolean}) {
  const router = useRouter();

  const handleHome = () => {
    router.push('/');
  }

  return (
    <ButtonBase
      component="span"
      onClick={handleHome}
    >
      {isOpen &&
        <h3 className='font-[800] duration-300 text-[24px] text-[#4880FF] m-0'>Class</h3>
      }
      <motion.img
      src='/images/logoAI.png'
      width='30px'
      
      transition={{ duration: 20 }}
      className={`origin-center pb-2 ${isOpen?'ml-1':''}`}
      />
    </ButtonBase>
  )
}
