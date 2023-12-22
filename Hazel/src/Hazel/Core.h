#pragma once

#ifdef HZ_PLATFORM_WINDOWS
#if HZ_DYNAMIC_LINK
	#ifdef HZ_BUILD_DLL
		#define HAZEL_API __declspec(dllexport)
	#else
		#define HAZEL_API __declspec(dllimport)
	#endif
#else
	#define HAZEL_API // 将 HAZEL_API 定义为空，也就是无效
#endif
#else
	#error Hazel only support Windows!
#endif

#define BIT(x) ( 1<<x )
#define HZ_BIND_EVENT_FN(fn) std::bind(&fn, this, std::placeholders::_1)