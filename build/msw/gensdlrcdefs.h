/*
 * Name:        gensdlrcdefs.h
 * Purpose:     Emit preprocessor symbols into rcdefs.h for resource compiler
 *              Modified wx/msw/genrcdefs.h
 * Author:      Mike Wetherell (modified by Scott M Anderson)
 * RCS-ID:      $Id: genrcdefs.h 36133 2005-11-08 22:49:46Z MW $
 * Copyright:   (c) 2005 Mike Wetherell
 * Licence:     wxWindows licence
 */

#define EMIT(line) line

EMIT(#ifndef _WX_RCDEFS_H)
EMIT(#define _WX_RCDEFS_H)

#ifdef _MSC_FULL_VER
#pragma comment(user, "Edit this file after building wx")
#pragma comment(user, "  so VC 8 and 10 can coexist in sdlExtern")
#pragma comment(user, "Replace...")
EMIT(#define WX_MSC_FULL_VER _MSC_FULL_VER)
#pragma comment(user, "With... (and remove quotes from _MSC_VER)")
EMIT(#if "_MSC_VER" >= 1600 /* VC 10.0 (aka 2010) */)
EMIT(#define WX_MSC_FULL_VER 160030319)
EMIT(#elif "_MSC_VER" >= 1400 /* VC 8.0 (aka 2005) */)
EMIT(#define WX_MSC_FULL_VER 140050727)
EMIT(#endif)
#pragma comment(user, "After verifying the version hasn't changed")
#pragma comment(user, "  for the compiler you're building with")
#endif

#ifdef _M_AMD64
EMIT(#define WX_CPU_AMD64)
#endif

#ifdef _M_ARM
EMIT(#define WX_CPU_ARM)
#endif

#ifdef _M_IA64
EMIT(#define WX_CPU_IA64)
#endif

#if defined _M_IX86 || defined _X86_
EMIT(#define WX_CPU_X86)
#endif

#ifdef _M_PPC
EMIT(#define WX_CPU_PPC)
#endif

#ifdef _M_SH
EMIT(#define WX_CPU_SH)
#endif

EMIT(#endif)
