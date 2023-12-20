#include <Hazel.h>

#include "imgui/imgui.h"

//namespace Hazel {
//	__declspec(dllimport) void Print();
//}


class ExampleLayer : public Hazel::Layer
{
public:
	ExampleLayer() : Layer("Example")
	{
		//auto cam = camera(5.0f, { 0.5f, 0.5f });
	}

	void OnUpdate() override
	{
		//HZ_INFO("ExampleLayer::Update");
		
		if (Hazel::Input::IsKeyPressed(Hazel::Key::Tab))
			HZ_TRACE("Tab key is pressed!");
	}

	//virtual void OnImGuiRender() override
	//{
	//	ImGui::Begin("Test");
	//	ImGui::Text("Hello World");
	//	ImGui::End();
	//}

	void OnEvent(Hazel::Event& event) override
	{
		if (event.GetEventType() == Hazel::EventType::KeyPressed)
		{
			Hazel::KeyPressedEvent& e = (Hazel::KeyPressedEvent&)event;
			if (e.GetKeyCode() == Hazel::Key::Tab)
				HZ_TRACE("Tab key is pressed (event)!");
			HZ_TRACE("{0}", (char)e.GetKeyCode());
		}
	}
};

class Sandbox : public Hazel::Application
{
public:
	Sandbox()
	{
		// 放入层
		PushLayer(new ExampleLayer());
		//PushOverlay(new Hazel::ImGuiLayer());
	}

	~Sandbox()
	{

	}
};

Hazel::Application* Hazel::CreateApplication() {
	return new Sandbox();
}