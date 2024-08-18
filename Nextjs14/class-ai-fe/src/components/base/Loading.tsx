import React from 'react'

export default function Loading() {
  return (
    <div className="bg-white absolute place-items-center grid h-screen w-full gap-4 z-[10000] ">   
      <div className="bg-purple-200 opacity-[0.8] w-48 h-48  absolute animate-ping rounded-full delay-5s shadow-md"></div>
      <div className="bg-blue-300 opacity-20 w-32 h-32 absolute animate-ping rounded-full shadow-xl"></div>
      <img src='/images/logoAI.png' className='w-20 h-20' />
    </div>
  )
}
