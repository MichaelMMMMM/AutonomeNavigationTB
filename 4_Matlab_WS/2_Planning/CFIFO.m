classdef CFIFO < handle
    properties
        mQ;
    end
    
    methods
        function ctor = CFIFO()
            ctor.mQ = {};
        end
        function push(this, n)
            this.mQ = [this.mQ, {n}];
        end
        function [n, flag] = pop(this)
            if(isempty(this.mQ))
                flag = 0;
                n    = 0;
            else
                n = this.mQ{1};
                this.mQ = this.mQ(2:end);
                flag = 1;
            end
        end
    end

end