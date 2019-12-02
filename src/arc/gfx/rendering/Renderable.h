#pragma once

#include "IShader.h"
#include "../../math/Mat4.h"
#include "../MeshPart.h"
#include "../Material.h"
#include "../Environement.h"
#include "../../utils/object_pool.hpp"

namespace arc
{
    class IShader;
    class Renderable
    {
    public:
        Renderable()= default;
        Renderable(const Renderable& other)
        {
            printf("what\n");
            worldTransform = other.worldTransform;
            // todo: meshpart
            material = other.material;
            environement = other.environement;
            bones = other.bones;
            shader = other.shader;
        };


        Mat4 worldTransform = Mat4::identity();
        MeshPart meshPart{};

        Material* material = nullptr;
        Environement* environement = nullptr;
        std::vector<Mat4>* bones = nullptr;
        IShader* shader = nullptr;
    };


    class IRenderableProvider
    {
    public:
        virtual void getRenderables(DynamicObjectPool<Renderable>& pool, std::vector<Renderable*>& renderables) = 0;
    };
}