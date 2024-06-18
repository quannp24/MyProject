import ButtonBase from '@mui/material/ButtonBase'
import React from 'react'

export default function LogoSection() {
  return (
    <ButtonBase
      component="span"
      onClick={() => alert('Button clicked!')}
    >
      <img src='/images/icon.png' width='40px' />
      <h3 className='uppercase font-bold text-[15px] ml-2'>Emulator</h3>
    </ButtonBase>
  )
}
