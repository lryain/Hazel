#pragma once

#include "Core.h"
#include "Window.h"

namespace Hazel {
	//class __declspec(dllexport) Application
	class HAZEL_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
	private:
		Window* m_Window;
		bool m_Running = true;
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}